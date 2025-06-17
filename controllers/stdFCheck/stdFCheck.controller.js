const { tb_m_tools_f_check_std } = require("../../config/table");
const getPaginatedData = require("../../functions/PAGINATION");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const {
  queryGET,
  queryPOST,
  queryTransaction,
  queryPUT,
  queryDELETE,
  querySoftDELETE,
} = require("../../helpers/query");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;
const { error, success } = require("../../helpers/response");
const moment = require("moment");

module.exports = {
  // addSdtFCheck: async (req, res) => {
  //   try {
  //     console.log("req.body", req.body);
  //     if (!Array.isArray(req.body) || req.body.length === 0) {
  //       throw new Error("Request body must be an array of measurements");
  //     }

  //     await queryTransaction(async (db) => {
  //       for (const measurement of req.body) {
  //         // Validate required fields
  //         if (!measurement.tool_id || !measurement.measuring_portion) {
  //           throw new Error(
  //             "Missing required fields: tool_id or measuring_portion"
  //           );
  //         }

  //         // Handle empty values for numeric columns and set is_judgment
  //         const cleanMeasurement = {
  //           ...measurement,
  //           measuring_portion: measurement.measuring_portion,
  //           gauge: measurement.gauge || null,
  //           qty_check: measurement.qty_check || null,
  //           dimension: measurement.dimension || null,
  //           upper_limit: measurement.upper_limit || null,
  //           lower_limit: measurement.lower_limit || null,
  //           units: measurement.units || null,
  //           system_std_used: measurement.system_std_used || null,
  //           created_dt: moment().format("YYYY-MM-DD HH:mm:ss"), // Current timestamp
  //           created_by: "system", // Placeholder, adjust as per actual logic
  //           deleted_dt: null,
  //           deleted_by: null,
  //         };

  //         // Set is_judgment to true if any of the specified fields are null
  //         cleanMeasurement.is_judgment =
  //           cleanMeasurement.dimension === null ||
  //           cleanMeasurement.upper_limit === null ||
  //           cleanMeasurement.lower_limit === null ||
  //           cleanMeasurement.units === null ||
  //           cleanMeasurement.system_std_used === null;

  //         // Build condition to check existing records
  //         const whereCond = ` WHERE tool_id = ${cleanMeasurement.tool_id} AND measuring_portion = '${cleanMeasurement.measuring_portion}' AND deleted_dt IS NULL`;

  //         // Check if the record already exists
  //         const existingRecord = await db.query(
  //           `SELECT * FROM ${tb_m_tools_f_check_std} ${whereCond}`
  //         );

  //         if (existingRecord.rows.length > 0) {
  //           // Record already exists, update it
  //           const setClause = Object.keys(cleanMeasurement)
  //             .map(
  //               (key) =>
  //                 `${key} = ${
  //                   cleanMeasurement[key] === null
  //                     ? "NULL"
  //                     : `'${cleanMeasurement[key]}'`
  //                 }`
  //             )
  //             .join(", ");

  //           await db.query(
  //             `UPDATE ${tb_m_tools_f_check_std} SET ${setClause} WHERE tool_id = ${cleanMeasurement.tool_id} AND measuring_portion = '${cleanMeasurement.measuring_portion}'`
  //           );
  //         } else {
  //           // Get the next ID using GET_LAST_ID
  //           const tool_f_check_std_id = await GET_LAST_ID(
  //             "tool_f_check_std_id",
  //             tb_m_tools_f_check_std
  //           );

  //           const measurementData = {
  //             tool_f_check_std_id,
  //             created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
  //             created_by: "SYSTEM",
  //             deleted_by: null,
  //             deleted_dt: null,
  //             ...cleanMeasurement,
  //           };
  //           await queryPOST(tb_m_tools_f_check_std, measurementData);
  //         }
  //       }

  //       res.status(201).json({
  //         message: "Success Add Sdt FCheck",
  //         data: { code: 1, message: "INSERTED" },
  //       });
  //     });
  //   } catch (error) {
  //     console.error(error);
  //     res.status(500).json({ message: error.message });
  //   }
  // },

  addSdtFCheck: async (req, res) => {
    try {
      console.log("req.body", req.body);
      if (!Array.isArray(req.body) || req.body.length === 0) {
        throw new Error("Request body must be an array of measurements");
      }

      await queryTransaction(async (db) => {
        for (const measurement of req.body) {
          if (!measurement.tool_id || !measurement.measuring_portion) {
            throw new Error(
              "Missing required fields: tool_id or measuring_portion"
            );
          }

          const cleanMeasurement = {
            ...measurement,
            gauge: measurement.gauge || null,
            qty_check: measurement.qty_check || null,
            dimension: measurement.dimension || null,
            upper_limit: measurement.upper_limit || null,
            lower_limit: measurement.lower_limit || null,
            units: measurement.units || null,
            system_std_used: measurement.system_std_used || null,
            created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
            created_by: "system",
            deleted_dt: null,
            deleted_by: null,
          };

          cleanMeasurement.is_judgment =
            cleanMeasurement.dimension === null ||
            cleanMeasurement.upper_limit === null ||
            cleanMeasurement.lower_limit === null ||
            cleanMeasurement.units === null ||
            cleanMeasurement.system_std_used === null;

          const whereCond = `WHERE tool_id = ${cleanMeasurement.tool_id} AND measuring_portion = '${cleanMeasurement.measuring_portion}' AND deleted_dt IS NULL`;

          const existingRecord = await db.query(
            `SELECT * FROM ${tb_m_tools_f_check_std} ${whereCond}`
          );

          if (existingRecord.rows.length > 0) {
            // Update existing record
            const oldData = existingRecord.rows[0];

            const setClause = Object.keys(cleanMeasurement)
              .map(
                (key) =>
                  `${key} = ${
                    cleanMeasurement[key] === null
                      ? "NULL"
                      : `'${cleanMeasurement[key]}'`
                  }`
              )
              .join(", ");

            await db.query(
              `UPDATE ${tb_m_tools_f_check_std} SET ${setClause} WHERE tool_id = ${cleanMeasurement.tool_id} AND measuring_portion = '${cleanMeasurement.measuring_portion}'`
            );

            // Check if upper/lower limit changed
            const isLimitChanged =
              cleanMeasurement.upper_limit !== oldData.upper_limit ||
              cleanMeasurement.lower_limit !== oldData.lower_limit;

            if (isLimitChanged) {
              // Update related tb_r_tool_f_checks status
              const resultChecks = await db.query(`
              SELECT * FROM tb_r_tool_f_checks 
              WHERE tool_id = ${cleanMeasurement.tool_id}
              AND measuring_portion = '${cleanMeasurement.measuring_portion}'
              AND deleted_dt IS NULL
            `);

              for (const check of resultChecks.rows) {
                let newStatus = "NG";
                const valueRaw = check.value_check;
                const value = parseFloat(valueRaw);
                const lower = parseFloat(cleanMeasurement.lower_limit);
                const upper = parseFloat(cleanMeasurement.upper_limit);

                const isNumeric = !isNaN(value);

                if (isNumeric && !isNaN(lower) && !isNaN(upper)) {
                  if (value >= lower && value <= upper) {
                    newStatus = "OK";
                  }
                } else {
                  // if non-numeric value_check, use the value as status if valid
                  newStatus = valueRaw?.toUpperCase() === "OK" ? "OK" : "NG";
                }

                await db.query(`
                UPDATE tb_r_tool_f_checks 
                SET status = '${newStatus}' 
                WHERE tool_f_check_id = ${check.tool_f_check_id}
              `);
              }
            }
          } else {
            // Insert new record
            const tool_f_check_std_id = await GET_LAST_ID(
              "tool_f_check_std_id",
              tb_m_tools_f_check_std
            );

            const measurementData = {
              tool_f_check_std_id,
              created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
              created_by: "SYSTEM",
              deleted_by: null,
              deleted_dt: null,
              ...cleanMeasurement,
            };

            await queryPOST(tb_m_tools_f_check_std, measurementData);
          }
        }

        res.status(201).json({
          message: "Success Add Sdt FCheck",
          data: { code: 1, message: "INSERTED" },
        });
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
  },

  getStdFCheck: async (req, res) => {
    try {
      let meta = req.query.meta;
      let condition = queryCondExacOpAnd(req.query);
      let whereCond = `${condDataNotDeleted} AND deleted_dt IS NULL${condition}`;
      if (meta) {
        const result = await getPaginatedData(
          tb_m_tools_f_check_std,
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
          tb_m_tools_f_check_std,
          whereCond + " ORDER BY created_dt DESC"
        );
        success(res, "Success", result);
      }
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
  },

  deleteStdFCheck: async (req, res) => {
    try {
      const tool_f_check_std_id = req.params.id;
      console.log("tool_f_check_Std_id", tool_f_check_std_id);
      const deleted_by = "SYSTEM";
      const deleted_dt = moment().format("YYYY-MM-DD HH:mm:ss");
      const data = { deleted_by, deleted_dt };
      const whereCond = `tool_f_check_std_id = ${tool_f_check_std_id}`;
      await querySoftDELETE(tb_m_tools_f_check_std, data, whereCond);
      res.status(200).json({
        message: "Success Delete Sdt FCheck",
        data: { code: 1, message: "DELETED" },
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
  },
};
