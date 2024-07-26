const { error, success } = require("../../helpers/response");
const { tb_m_lines } = require("../../config/table");

const {
  queryGET,
  queryPOST,
  queryTransaction,
  queryDELETE,
  querySoftDELETE,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const getPaginatedData = require("../../functions/PAGINATION");
const moment = require("moment");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");

module.exports = {
  getLines: async (req, res) => {
    try {
      let meta = req.query.meta;
      let conditions = queryCondExacOpAnd(req.query);
      let whereCond = `${condDataNotDeleted} AND deleted_dt IS NULL${conditions}`;

      if (meta) {
        const result = await getPaginatedData(tb_m_lines, meta.currentPage);
        success(res, "Success", result);
      } else {
        let result = await queryGET(tb_m_lines, whereCond);
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },

  addLine: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil line_id terakhir dari tb_m_lines
        let line_id = await GET_LAST_ID("line_id", "tb_m_lines");
        req.body.line_id = line_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_lines
        console.log(req.body);
        let responseInserted = await queryPOST("tb_m_lines", req.body, db);
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add Line",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  deleteLine: async (req, res) => {
    try {
      const line_id = req.params.id;
      console.log(line_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");

      // Data yang akan diupdate
      const data = { deleted_by, deleted_dt };

      // Kondisi where
      const whereCond = `line_id = ${line_id}`;

      // Panggil querySoftDELETE dengan parameter yang sesuai
      await querySoftDELETE("tb_m_lines", data, whereCond);

      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "DELETED" },
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: error.message });
    }
  },
};
