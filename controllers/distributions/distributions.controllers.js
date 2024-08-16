const { error, success } = require("../../helpers/response");
const { tb_m_distributions } = require("../../config/table");
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
  getDistributions: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_distributions,
          meta.currentPage,
          meta.itemsPerPage,
          `system_std_used = '${req.query.system_std_used}'`,
          "created_dt"
        );
        success(res, "Success", result);
      } else {
        let conditions = queryCondExacOpAnd(req.query);
        let result = await queryGET(
          tb_m_distributions,
          condDataNotDeleted + conditions + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
  addDistribution: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil line_id terakhir dari tb_m_lines
        let distribution_id = await GET_LAST_ID(
          "distribution_id",
          tb_m_distributions
        );
        req.body.distribution_id = distribution_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_lines
        console.log(req.body);
        let responseInserted = await queryPOST(
          tb_m_distributions,
          req.body,
          db
        );
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add Distribution",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  editDistribution: async (req, res) => {
    try {
      const distribution_id = req.params.id;
      console.log(distribution_id);

      const data = req.body;
      console.log(data);

      const whereCond = `WHERE distribution_id = ${distribution_id}`;

      await queryPUT(tb_m_distributions, data, whereCond);

      res.status(201).json({
        message: "Success Update Distribution",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  deleteDistribution: async (req, res) => {
    try {
      const distribution_id = req.params.id;
      console.log(distribution_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");

      // Data yang akan diupdate
      const data = { deleted_by, deleted_dt };

      // Kondisi where
      const whereCond = `distribution_id = ${distribution_id}`;

      // Panggil querySoftDELETE dengan parameter yang sesuai
      await querySoftDELETE(tb_m_distributions, data, whereCond);

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
