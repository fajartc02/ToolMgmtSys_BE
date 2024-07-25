const { error, success } = require("../../helpers/response");
const { tb_m_distributions } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
    getDistributions: async(req, res) => {
        try {
            let meta = req.query.meta;
            if (meta) {
                const result = await getPaginatedData(
                    tb_m_distributions,
                    meta.currentPage,
                    meta.itemsPerPage,
                    `system_std_used = '${req.query.system_std_used}'`
                );
                success(res, "Success", result);
            } else {
                let conditions = queryCondExacOpAnd(req.query);
                let result = await queryGET(
                    tb_m_distributions,
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