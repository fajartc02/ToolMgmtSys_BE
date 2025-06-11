const {
  tb_m_master_tools_f_check,
  tb_m_tool_types,
} = require("../../config/table");
const getPaginatedData = require("../../functions/PAGINATION");
const {
  queryGET,
  queryCondExacOpAnd,
  queryCustom,
  queryTransaction,
  queryPOST,
  queryPUT,
  querySoftDELETE,
} = require("../../helpers/query");
const moment = require("moment");
const { error, success } = require("../../helpers/response");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const { login } = require("../authController");

module.exports = {
  getMasterTool: async (req, res) => {
    try {
      let meta = req.query.meta;
      const line_id = req.query.line_id;
      const tool_id = req.query.tool_id;
      console.log("meta", meta);

      console.log("tool_id", tool_id);
      console.log("line_id", line_id);

      // Konfigurasi JOIN untuk mengambil `line_nm` dari `tb_m_lines`
      const joinCondition = `
    LEFT JOIN tb_m_lines ON tb_m_master_tools_f_check.line_id = tb_m_lines.line_id
  `;
      const joinColumns = `tb_m_lines.line_nm`; // Kolom tambahan yang diambil dari JOIN

      if (meta) {
        const result = await getPaginatedData(
          tb_m_master_tools_f_check,
          meta.currentPage,
          meta.itemsPerPage,
          null,
          "tb_m_master_tools_f_check.created_dt",
          joinCondition,
          joinColumns,
          true
        );

        success(res, "Success", result);
      } else {
        console.log("🟢 MASUK TANPA PAGINATION");

        // Bangun kondisi filter dinamis
        let filters = "WHERE fc.deleted_dt IS NULL";

        if (line_id) {
          filters += ` AND fc.line_id = ${line_id}`;
        }

        if (tool_id) {
          filters += ` AND fc.tool_id = ${tool_id}`;
        }

        // Query SQL lengkap
        const q = `
                    SELECT 
                      fc.*, 
                      l.line_nm
                    FROM tb_m_master_tools_f_check fc
                    LEFT JOIN tb_m_lines l ON fc.line_id = l.line_id
                    ${filters}
                    ORDER BY fc.created_dt DESC
                  `;

        const result = await queryCustom(q);
        // Tambahkan properti `no` ke setiap item di rows
        const withNumbering = result.rows.map((item, index) => ({
          no: index + 1,
          ...item,
        }));
        // Kirim ke FE sesuai format Vuex kamu: response.data.data.data
        res.status(200).json({
          message: "Success",
          data: {
            data: withNumbering,
          },
        });
      }
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
  addMasterTool: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil ID  terakhir dari tb_m_drawings
        let tool_id = await GET_LAST_ID("tool_id", tb_m_master_tools_f_check);
        req.body.tool_id = tool_id;
        let new_tool_type_id = await GET_LAST_ID(
          "tool_type_id",
          tb_m_tool_types
        );
        const drawing = {
          tool_type_id: new_tool_type_id,
          tool_type_nm: req.body.tool_nm,
          tool_type_desc: req.body.process_nm,
          std_counter: req.body.std_ctr,
        };
        await queryPOST(tb_m_tool_types, drawing, db);

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_drawings

        let responseInserted = await queryPOST(
          tb_m_master_tools_f_check,
          req.body,
          db
        );
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add Drawing",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: err.message });
    }
  },
  editMasterTool: async (req, res) => {
    try {
      const tool_id = req.body.tool_id;
      console.log("tool_id", tool_id);

      const data = req.body;
      console.log("data", data);
      const whereCond = `WHERE tool_id = ${tool_id}`;
      await queryPUT(tb_m_master_tools_f_check, data, whereCond);

      res.status(201).json({
        message: "Success Edit Drawing",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: error.message });
    }
  },
  deleteMasterTool: async (req, res) => {
    try {
      const tool_id = req.params.id;
      console.log(tool_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");
      const data = { deleted_by, deleted_dt };
      const whereCond = `tool_id = ${tool_id}`;
      await querySoftDELETE(tb_m_master_tools_f_check, data, whereCond);

      res.status(201).json({
        message: "Success Delete Drawing",
        data: { code: 1, message: "DELETED" },
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: error.message });
    }
  },
};
