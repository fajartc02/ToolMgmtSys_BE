const { tb_m_tool_types } = require("../../config/table");
const getPaginatedData = require("../../functions/PAGINATION");
const {
  queryPOST,
  queryTransaction,
  queryGET,
} = require("../../helpers/query");
const { error, success } = require("../../helpers/response");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const moment = require("moment");

module.exports = {
  getDrawings: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_tool_types,
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
          tb_m_tool_types,
          conditionalDataNotDeleted + conditions + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
  addDrawing: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil ID gambar terakhir dari tb_m_drawings
        let tool_type_id = await GET_LAST_ID("tool_type_id", tb_m_tool_types);
        req.body.tool_type_id = tool_type_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Jika ada file, tambahkan ke req.body
        if (req.file) {
          req.body.ilustrations = `uploads/${req.file.filename}`; // Simpan path file atau sesuai kebutuhan
        }

        // Insert data baru ke tb_m_drawings
        console.log(req.body);
        let responseInserted = await queryPOST(tb_m_tool_types, req.body, db);
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
  editDrawing: async (req, res) => {
    try {
      const tool_type_id = req.params.id;
      console.log(req.params);
      const updatedFields = req.body;
      // Convert created_dt to the desired format if it exists in the request body
      if (updatedFields.created_dt) {
        updatedFields.created_dt = moment(
          updatedFields.created_dt,
          "DD-MM-YYYY"
        ).format("YYYY-MM-DD");
      }
      // If there's a file in the request, add its path to the updated fields
      if (req.file) {
        updatedFields.ilustrations = `uploads/${req.file.filename}`;
      }
      // Build the update query dynamically
      let setClause = Object.keys(updatedFields)
        .map((key) => `${key} = '${updatedFields[key]}'`)
        .join(", ");

      const query = `UPDATE ${tb_m_tool_types} SET ${setClause} WHERE tool_type_id = '${tool_type_id}' RETURNING *`;

      await queryTransaction(async (db) => {
        const responseUpdated = await db.query(query);
        return responseUpdated;
      });

      res.status(201).json({
        message: "Success Edit Drawing",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: err.message });
    }
  },
  searchDrawing: async (req, res) => {
    try {
      let meta = req.query.meta;
      const search = req.query.search;

      if (meta) {
        const result = await getPaginatedData(
          tb_m_tool_types,
          meta.currentPage,
          meta.itemsPerPage,
          `tool_type_nm ILIKE '%${search}%'`,
          "created_dt",
          null,
          null,
          true
        );
        success(res, "Success", result);
      } else {
        let conditions = queryCondExacOpAnd(req.query);

        // Menambahkan kondisi pencarian jika `search` parameter diberikan
        if (search) {
          conditions += ` AND (tool_type_nm ILIKE '%${search}%'`;
          // Ganti `column1` dan `column2` dengan kolom yang sesuai untuk pencarian.
        }

        let result = await queryGET(
          tb_m_tool_types,
          conditionalDataNotDeleted + conditions + " ORDER BY created_dt DESC"
        );

        success(res, "Success", result);
      }
    } catch (error) {
      console.error(error);
      error(res, "Error fetching search results", error);
    }
  },

  // searchDrawing: async (req, res) => {
  //   try {
  //     const search = req.query.search;

  //     // Jika ada parameter pencarian, tambahkan kondisi WHERE
  //     let conditions = `WHERE deleted_dt IS NULL AND (
  //       tool_type_nm ILIKE '%${search}%'
  //     ) ORDER BY created_dt DESC`;

  //     // Jalankan query pencarian
  //     const result = await queryGET(tb_m_tool_types, conditions);

  //     success(res, "Success", result);
  //   } catch (err) {
  //     console.error(err);
  //     error(res, "Error fetching search results", err);
  //   }
  // },
};
