const { error, success, notFound } = require("../../helpers/response");
const { tb_m_tools_type_std } = require("../../config/table");

const getPaginatedData = require("../../functions/PAGINATION");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const { queryGET } = require("../../helpers/query");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
module.exports = {
  getToolStandard: async (req, res) => {
    try {
      const meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_tools_type_std,
          meta.currentPage,
          meta.itemsPerPage,
          ` system_std_used = '${req.query.system_std_used}' AND tool_type_id = '${req.query.tool_type_id}'`,
          null,
          null,
          null,
          true
        );
        success(res, "Success", result);
      } else {
        let conditions = queryCondExacOpAnd(req.query);
        let result = await queryGET(
          tb_m_tools_type_std,
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
