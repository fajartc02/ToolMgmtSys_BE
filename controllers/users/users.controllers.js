const { error, success } = require("../../helpers/response");
const { tb_m_users } = require("../../config/table");
const {
  queryGET,
  queryTransaction,
  queryPOST,
  queryPUT,
  querySoftDELETE,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const moment = require("moment");

const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
  getUsers: async (req, res) => {
    try {
      const result = await queryGET(tb_m_users);
      success(res, "Success", result);
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
  getUserOptions: async (req, res) => {
    try {
      // Mengambil parameter filter dari URL
      const filters = req.params.filters;
      console.log(filters);

      // Membangun kondisi WHERE dinamis
      let whereCond = condDataNotDeleted; // Kondisi default untuk memastikan data belum dihapus

      // Menambahkan filter dari parameter
      if (filters) {
        // Membagi filters menjadi pasangan key-value
        let filterConditions = queryCondExacOpAnd({ user_ln: filters });
        if (filterConditions) {
          // Menambahkan filter ke kondisi WHERE
          whereCond += ` ${filterConditions}`;
        }
      }

      // Mendapatkan data dari database dengan filter
      const result = await queryGET(tb_m_users, whereCond);
      success(res, "Success", result);
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
  addUser: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil line_id terakhir dari tb_m_lines
        let user_id = await GET_LAST_ID("user_id", tb_m_users);
        req.body.user_id = user_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_lines
        console.log(req.body);
        let responseInserted = await queryPOST(tb_m_users, req.body, db);
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add User",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  getUserMeta: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_users,
          meta.currentPage,
          meta.itemsPerPage,
          null,
          "created_dt",
          null,
          null,
          true
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
  editUser: async (req, res) => {
    try {
      const id = req.params.id;
      const data = req.body;

      const whereCond = `WHERE user_id = ${id}`;

      await queryPUT(tb_m_users, data, whereCond);

      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: error.message });
    }
  },
  deleteUser: async (req, res) => {
    try {
      const id = req.params.id;
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");
      const whereCond = `user_id = ${id}`;
      const data = { deleted_by, deleted_dt };
      await querySoftDELETE(tb_m_users, data, whereCond);
      res.status(201).json({
        message: "Success Delete User",
        data: { code: 1, message: "DELETED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
};
