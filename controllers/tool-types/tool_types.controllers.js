const { error, success } = require("../../helpers/response");
const { tb_m_tool_types } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;

module.exports = {
    getToolTypes: async(req, res) => {
        try {
            let conditions = queryCondExacOpAnd(req.query);
            let result = await queryGET(
                tb_m_tool_types,
                condDataNotDeleted + conditions
            );
            success(res, "Success", result);
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
};