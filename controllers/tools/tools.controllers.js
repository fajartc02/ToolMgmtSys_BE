const { error, success } = require("../../helpers/response");
const { tb_r_tools, tb_t_tools_positions } = require("../../config/table");
const {
    queryGET,
    queryPOST,
    queryTransaction,
    queryCustom,
    queryPUT,
    queryPostTransaction,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const GENERATE_TOOL_QR = require("../../functions/GENERATE_TOOL_QR");
const GENERATE_TOOL_NO = require("../../functions/GENERATE_TOOL_NO");
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
    getTools: async(req, res) => {
        try {
            let meta = req.query.meta;
            if (meta) {
                const result = await getPaginatedData(
                    tb_r_tools,
                    meta.currentPage,
                    meta.itemsPerPage,
                    null,
                    "created_dt"
                );
                success(res, "Success", result);
            } else {
                let conditions = queryCondExacOpAnd(req.query);
                let result = await queryGET(
                    tb_r_tools,
                    condDataNotDeleted + conditions + " ORDER BY created_dt DESC"
                );
                success(res, "Success", result);
            }
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
    generateToolQR: async(req, res) => {
        try {
            let result = await queryGET(
                tb_r_tools,
                " ORDER BY tool_id DESC LIMIT 1", ["tool_qr"]
            );
            console.log(result);
            let QRCodeTool = GENERATE_TOOL_QR(result[0].tool_qr);

            success(res, "Success", [{
                tool_qr: QRCodeTool,
            }, ]);
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
    addTool: async(req, res) => {
        try {
            await queryTransaction(async(db) => {
                let tool_id = GET_LAST_ID("tool_id", tb_r_tools);
                let tool_position_id = GET_LAST_ID(
                    "tool_position_id",
                    tb_t_tools_positions
                );
                req.body.tool_id = tool_id;

                req.body.tool_no = await GENERATE_TOOL_NO(
                    req.body.tool_type_id,
                    db,
                    req.body.tool_type_nm
                );

                delete req.body.tool_type_nm;
                console.log(req.body);
                console.log(req.body);
                let obj = {
                    tool_position_id,
                    tool_id,
                    act_counter: "0",
                    regrinding_count: "0",
                    distribution_id: "1",
                };
                await queryPostTransaction(db, tb_t_tools_positions, obj);
                let responseInserted = await queryPOST(tb_r_tools, req.body);
                return responseInserted;
            });
            success(res, "Success", { code: 1, message: "INSERTED" });
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
    updatePos: async(req, res) => {
        try {
            console.log(req.body);
            await queryPUT(
                tb_t_tools_positions,
                req.body,
                ` WHERE tool_id = (SELECT tool_id FROM ${tb_r_tools} WHERE tool_qr = '${req.query.tool_qr}')`
            );
            success(res, "Success", { code: 1, message: "UPDATED" });
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
};