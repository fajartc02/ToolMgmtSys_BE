const { tb_m_tools_type_std, tb_m_tool_types } = require("../../config/table");
const getPaginatedData = require("../../functions/PAGINATION");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const {
  querySoftDELETE,
  queryTransaction,
  queryPOST,
  queryGET,
  queryPUT,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const { error, success } = require("../../helpers/response");
const moment = require("moment");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;

module.exports = {
  getMeasurements: async (req, res) => {
    try {
      let meta = req.query.meta;
      let condition = queryCondExacOpAnd(req.query);
      let whereCond = `${condDataNotDeleted} AND deleted_dt IS NULL${condition}`;

      if (meta) {
        const result = await getPaginatedData(
          tb_m_tools_type_std,
          null,
          null,
          null,
          "created_dt",
          null,
          null,
          true
        );
        success(res, "Success", result);
      } else {
        let result = await queryGET(
          tb_m_tools_type_std,
          whereCond + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.error(err);
      error(res, "Error fetching data", err);
    }
  },
  deleteMeasureament: async (req, res) => {
    try {
      const tool_type_std_id = req.params.id;
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");

      // Data yang akan diupdate
      const data = { deleted_by, deleted_dt };
      // Kondisi where
      const whereCond = `tool_type_std_id = ${tool_type_std_id}`;

      // Panggil querySoftDELETE dengan parameter yang sesuai
      await querySoftDELETE(tb_m_tools_type_std, data, whereCond);
      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "DELETED" },
      });
    } catch (err) {
      console.error(err);
      error(res, "Error deleting data", err);
    }
  },
  addMeasurements: async (req, res) => {
    try {
      console.log("Incoming request body:", req.body);

      if (!Array.isArray(req.body) || req.body.length === 0) {
        throw new Error("Request body must be an array of measurements");
      }

      await queryTransaction(async (db) => {
        for (const measurement of req.body) {
          // Validate required fields
          if (!measurement.tool_type_id || !measurement.measuring_portion) {
            throw new Error(
              "Missing required fields: tool_type_id or measuring_portion"
            );
          }
          // Handle empty values for numeric columns
          const cleanMeasurement = {
            ...measurement,
            dimension: measurement.dimension || null,
            upper_limit: measurement.upper_limit || null,
            lower_limit: measurement.lower_limit || null,
            units: measurement.units || null,
            system_std_used: measurement.system_std_used || null,
          };
          // Build condition to check existing records
          const whereCond = ` WHERE tool_type_id = ${cleanMeasurement.tool_type_id} AND measuring_portion = '${cleanMeasurement.measuring_portion}' AND deleted_dt IS NULL`;

          // Check if the record exists
          const existingRecord = await queryGET(tb_m_tools_type_std, whereCond);

          if (existingRecord.length > 0) {
            // Record exists, update it
            const measurementData = {
              ...measurement,
            };
            await queryPUT(tb_m_tools_type_std, measurementData, whereCond);
          } else {
            // Record does not exist, insert new record
            const tool_type_std_id = await GET_LAST_ID(
              "tool_type_std_id",
              tb_m_tools_type_std
            );

            const measurementData = {
              tool_type_std_id,
              created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
              created_by: "SYSTEM",
              deleted_by: null,
              deleted_dt: null,
              ...cleanMeasurement,
            };

            // Add condition for is_judgment
            if (measurementData.measuring_portion === "Internal Coolant") {
              measurementData.is_judgment = true;
            }

            await queryPOST(tb_m_tools_type_std, measurementData);
          }
        }
      });

      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "UPDATED" },
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: error.message });
    }
  },
  deleteDrawing: async (req, res) => {
    try {
      const tool_type_id = req.params.id;
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");
      // Validasi input
      if (!tool_type_id) {
        return res.status(400).json({ message: "Invalid tool_type_id" });
      }

      // Data yang akan diupdate
      const data = { deleted_by, deleted_dt };
      // Kondisi where
      const whereCond = `tool_type_id = ${tool_type_id}`;

      // Panggil querySoftDELETE dengan parameter yang sesuai
      await querySoftDELETE(tb_m_tools_type_std, data, whereCond);

      // Soft delete dari tb_m_tool_type
      const whereCondToolType = `tool_type_id = ${tool_type_id}`;
      await querySoftDELETE(tb_m_tool_types, data, whereCondToolType);
      res.status(201).json({
        message: "Success",
        data: { code: 1, message: "DELETED" },
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: error.message });
    }
  },
};
