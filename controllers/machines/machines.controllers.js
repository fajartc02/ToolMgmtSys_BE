const { error, success } = require("../../helpers/response");
const { tb_m_machines, tb_m_lines } = require("../../config/table");
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
  getMachines: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_machines,
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
          condDataNotDeleted + conditions + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
  addMachine: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Ambil machine_id terakhir dari tb_m_machines
        let machine_id = await GET_LAST_ID("machine_id", "tb_m_machines");
        req.body.machine_id = machine_id;

        // Set additional fields
        req.body.created_dt = moment().format("YYYY-MM-DD HH:mm:ss");
        req.body.deleted_by = null;
        req.body.deleted_dt = null;

        // Insert data baru ke tb_m_machines
        console.log(req.body);
        let responseInserted = await queryPOST(tb_m_machines, req.body, db);
        return responseInserted;
      });
      res.status(201).json({
        message: "Success Add Machine",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  editMachines: async (req, res) => {
    try {
      const machine_id = req.params.id;
      console.log(machine_id);

      const data = req.body;

      const wherCond = `WHERE machine_id = '${machine_id}'`;
      await queryPUT(tb_m_machines, data, wherCond);

      res.status(201).json({
        message: "Success Edit Machine",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: err.message });
    }
  },
  deleteMachine: async (req, res) => {
    try {
      const machine_id = req.params.id;
      console.log(machine_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");

      // Data yang akan diupdate
      const data = { deleted_by, deleted_dt };

      // Kondisi where
      const whereCond = `machine_id = ${machine_id}`;

      // Panggil querySoftDELETE dengan parameter yang sesuai
      await querySoftDELETE(tb_m_machines, data, whereCond);

      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "DELETED" },
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: err.message });
    }
  },
  getMachinesOptions: async (req, res) => {
    try {
      // Mendapatkan parameter query untuk filter
      const filters = req.query;

      // Membangun kondisi WHERE dinamis untuk mencari line_id di tb_m_lines
      let lineFilterConditions = queryCondExacOpAnd(filters);
      let lineWhereCond = condDataNotDeleted; // Kondisi default untuk memastikan data belum dihapus
      if (lineFilterConditions) {
        lineWhereCond += ` ${lineFilterConditions.replace(
          /location/g,
          "line_nm"
        )}`;
      }

      // Mendapatkan line_id dari tb_m_lines berdasarkan kondisi yang dibangun
      const lines = await queryGET(tb_m_lines, lineWhereCond, ["line_id"]);
      if (lines.length === 0) {
        return success(res, "No machines found", []);
      }

      // Ekstrak semua line_id yang ditemukan
      const lineIds = lines.map((line) => line.line_id);

      // Membangun kondisi WHERE dinamis untuk memfilter data di tb_m_machines berdasarkan line_id
      let machineWhereCond = condDataNotDeleted; // Kondisi default untuk memastikan data belum dihapus
      machineWhereCond += ` AND line_id = ${lineIds
        .map((id) => `'${id}'`)
        .join(",")}`;

      // Mendapatkan data dari tb_m_machines berdasarkan kondisi yang dibangun
      const result = await queryGET(tb_m_machines, machineWhereCond);
      success(res, "Success", result);
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
};
