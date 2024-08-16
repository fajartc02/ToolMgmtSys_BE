const { error, success } = require("../../helpers/response");
const { tb_m_systems } = require("../../config/table");
const {
  queryGET,
  queryTransaction,
  queryPOST,
  queryPUT,
  querySoftDELETE,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const getPaginatedData = require("../../functions/PAGINATION");
const moment = require("moment");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");

module.exports = {
  getSystems: async (req, res) => {
    try {
      let meta = req.query.meta;
      console.log(req.query);
      if (meta) {
        const result = await getPaginatedData(
          tb_m_systems,
          meta.currentPage,
          null,
          `system_type = '${req.query.system_type}'`,
          "created_dt",
          null,
          null,
          true
        );
        success(res, "Success", result);
      } else {
        let conditions = queryCondExacOpAnd(req.query);
        let result = await queryGET(
          tb_m_systems,
          condDataNotDeleted + conditions + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
  addSystem: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil line_id terakhir dari tb_m_lines
        let system_id = await GET_LAST_ID("system_id", tb_m_systems);
        req.body.system_id = system_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_lines
        console.log(req.body);
        let responseInserted = await queryPOST(tb_m_systems, req.body, db);
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add System",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  editSystem: async (req, res) => {
    try {
      system_id = req.params.id;
      console.log(system_id);

      const data = req.body;
      console.log(data);

      const whereCond = `WHERE system_id = ${system_id}`;

      await queryPUT(tb_m_systems, data, whereCond);
      res.status(201).json({
        message: "Success Update System",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  deleteSystem: async (req, res) => {
    try {
      system_id = req.params.id;
      console.log(system_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");

      const data = { deleted_by, deleted_dt };

      const whereCond = `system_id = ${system_id}`;

      await querySoftDELETE(tb_m_systems, data, whereCond);
      res.status(201).json({
        message: "Success Delete System",
        data: { code: 1, message: "DELETED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
};
