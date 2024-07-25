const { error, success } = require("../../helpers/response");
const { tb_m_systems } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
    getSystems: async(req, res) => {
        try {
            let meta = req.query.meta;
            console.log(req.query);
            if (meta) {
                const result = await getPaginatedData(
                    tb_m_systems,
                    meta.currentPage,
                    null,
                    `system_type = '${req.query.system_type}'`
                );
                success(res, "Success", result);
            } else {
                let conditions = queryCondExacOpAnd(req.query);
                let result = await queryGET(
                    tb_m_systems,
                    condDataNotDeleted + conditions
                );
                success(res, "Success", result);
            }
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
};