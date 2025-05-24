const { error, success, notFound } = require("../../helpers/response");
const {
  tb_m_tools_type_std,
  tb_r_tools_histories,
  tb_r_tool_checks,
  tb_t_tools_positions,
  v_tools_histories,
} = require("../../config/table");

const getPaginatedData = require("../../functions/PAGINATION");
const {
  queryTransaction,
  queryPostTransaction,
  queryPutTransaction,
  queryGET,
  queryCustom,
} = require("../../helpers/query");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");

module.exports = {
  submitToolHistory: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        console.log(req.body);
        let regrinding_count = req.body.headerData.regrinding_count;
        delete req.body.headerData.regrinding_count;
        req.body.headerData.tool_history_id = GET_LAST_ID(
          "tool_history_id",
          tb_r_tools_histories
        );
        let systemProblem = null;

        if (
          req.body.headerData.system_activity == "REGRINDING" &&
          req.body.checkData
        ) {
          // Ambil reg_cnt terakhir berdasarkan tool_id
          const result = await queryCustom(
            `SELECT COALESCE(MAX(reg_cnt), 0) AS max_cnt FROM tb_r_tools_histories WHERE tool_id = ${req.body.headerData.tool_id}`
          );

          // Pastikan ambil dari result.rows[0]
          const lastRegCnt = result.rows?.[0]?.max_cnt || 0;
          // Set nilai reg_cnt berikutnya
          const nextRegCnt = lastRegCnt + 1;
          req.body.headerData.reg_cnt = nextRegCnt;

          await req.body.checkData.map(async (item) => {
            item.tool_check_id = GET_LAST_ID("tool_check_id", tb_r_tool_checks);
            item.tool_history_id = req.body.headerData.tool_history_id;
            await queryPostTransaction(db, tb_r_tool_checks, item);
            return item;
          });

          await queryPutTransaction(
            db,
            tb_t_tools_positions,
            {
              regrinding_count: regrinding_count + 1, // ADD TR COUNT
              distribution_id: 1, // READY TO SEND CLEAN ROOM
              act_counter: "0", // RESET ACTIVITY COUNTER
              machine_id: "null",
              system_problem: systemProblem,
            },
            ` WHERE tool_id = ${req.body.headerData.tool_id}`
          );
        } else if (req.body.headerData.system_activity == "SCRAB") {
          await queryPutTransaction(
            db,
            tb_t_tools_positions,
            {
              act_counter: req.body.headerData.act_counter, // RESET ACTIVITY COUNTER,
              distribution_id: 1000, // SCRAB tool
              is_scrab: true,
              machine_id: "null",
              act_counter: "0",
            },
            ` WHERE tool_id = ${req.body.headerData.tool_id}`
          );
        } else if (req.body.headerData.system_activity == "IN USED") {
          await queryPutTransaction(
            db,
            tb_t_tools_positions,
            {
              act_counter: req.body.headerData.act_counter,
              distribution_id: req.body.headerData.distribution_id,
              machine_id: req.body.headerData.machine_id,
              system_problem: null,
            },
            ` WHERE tool_id = ${req.body.headerData.tool_id}`
          );
        } else if (req.body.headerData.system_activity == "USED") {
          console.log(req.body.headerData);
          systemProblem = req.body.headerData.system_problem; // Store system_problem
          await queryPutTransaction(
            db,
            tb_t_tools_positions,
            {
              act_counter: +req.body.headerData.act_counter,
              distribution_id: req.body.headerData.distribution_id,
              system_problem: req.body.headerData.system_problem,
            },
            ` WHERE tool_id = ${req.body.headerData.tool_id}`
          );
        } else if (req.body.headerData.system_activity == "SETTING") {
          // Menyimpan data checkData ke tb_r_tool_checks
          await req.body.checkData.map(async (item) => {
            item.tool_check_id = GET_LAST_ID("tool_check_id", tb_r_tool_checks);
            item.tool_history_id = req.body.headerData.tool_history_id;
            await queryPostTransaction(db, tb_r_tool_checks, item);
            return item;
          });

          await queryPutTransaction(
            db,
            tb_t_tools_positions,
            {
              distribution_id: req.body.headerData.distribution_id,
              machine_id: "null",
              system_problem: "null",
              act_counter: "0",
            },
            ` WHERE tool_id = ${req.body.headerData.tool_id}`
          );
        }

        await queryPostTransaction(
          db,
          tb_r_tools_histories,
          req.body.headerData
        );
        return true;
      });
      success(res, "Success", { code: 1, message: "INSERTED" });
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
  // getToolHistories: async (req, res) => {
  //   try {
  //     let meta = req.query.meta;
  //     if (meta) {
  //       const result = await getPaginatedData(
  //         "v_tools_histories",
  //         meta.currentPage,
  //         meta.itemsPerPage,
  //         `tool_qr = '${req.query.tool_qr}'`,
  //         "tool_history_id",
  //         null,
  //         false // Set to false if v_tools_histories table does not have deleted_dt column
  //       );
  //       success(res, "Success", result);
  //     } else {
  //       let result = await queryGET("v_tools_histories");
  //       success(res, "Success", result);
  //     }
  //   } catch (err) {
  //     console.log(err);
  //     error(res, err);
  //   }
  // },
  getToolHistories: async (req, res) => {
    try {
      let meta = req.query.meta;
      const toolQr = req.query.tool_qr;

      if (meta) {
        const joinCondition = `
        LEFT JOIN tb_r_tools_histories h ON v_tools_histories.tool_history_id = h.tool_history_id
        LEFT JOIN tb_m_machines m ON h.machine_id = m.machine_id
      `;

        const joinColumns = `m.machine_nm`;

        const result = await getPaginatedData(
          "v_tools_histories",
          meta.currentPage,
          meta.itemsPerPage,
          `v_tools_histories.tool_qr = '${toolQr}'`,
          "v_tools_histories.date_check",
          joinCondition,
          joinColumns,
          false
        );
        // Tambahkan log data hasil query
        console.log("[DEBUG] Data with machine_nm:", result.data);
        success(res, "Success", result);
      } else {
        const sql = `
        SELECT vth.*, m.machine_nm
        FROM v_tools_histories vth
        LEFT JOIN tb_r_histories h ON vth.tool_history_id = h.tool_history_id
        LEFT JOIN tb_m_machines m ON h.machine_id = m.machine_id
        WHERE vth.tool_qr = '${req.query.tool_qr}'
      `;
        const result = await queryCustom(sql);
        success(res, "Success", result.rows);
      }
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
};
