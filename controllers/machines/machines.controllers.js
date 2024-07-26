const { error, success } = require("../../helpers/response");
const { tb_m_machines } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
  getMachines: async (req, res) => {
    try {
      let meta = req.query.meta;
      console.log(req.query);
      if (meta) {
        const result = await getPaginatedData(
          tb_m_machines,
          meta.currentPage,
          meta.itemsPerPage
          //   `line_id = (SELECT line_id FROM tb_m_lines WHERE line_nm = '${req.query.location}')`
        );
        success(res, "Success", result);
      } else {
        let conditions = queryCondExacOpAnd(req.query);
        let result = await queryGET(
          tb_m_machines,
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
