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
  getToolHistories: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          "v_tools_histories",
          meta.currentPage,
          meta.itemsPerPage,
          `tool_qr = '${req.query.tool_qr}'`,
          "tool_history_id",
          null,
          false // Set to false if v_tools_histories table does not have deleted_dt column
        );
        success(res, "Success", result);
      } else {
        let result = await queryGET("v_tools_histories");
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(err);
      error(res, err);
    }
  },
};
