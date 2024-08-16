const { error, success } = require("../../helpers/response");
const {
  v_tools_histories,
  tb_r_tool_checks,
  tb_r_tools_histories,
} = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const getPaginatedData = require("../../functions/PAGINATION");
const moment = require("moment");

module.exports = {
  getRegrinding: async (req, res) => {
    try {
      let meta = req.query.meta;
      if (meta) {
        const result = await getPaginatedData(
          v_tools_histories,
          meta.currentPage,
          meta.itemsPerPage,
          `system_activity = 'REGRINDING'`,
          "tool_history_id",
          null,
          false // Set to false if v_tools_histories table does not have deleted_dt column
        );
        success(res, "Success", result);
      } else {
        let result = await queryGET(
          v_tools_histories,
          `system_activity = 'REGRINDING'`
        );
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(error);
      res.status(500).json({ message: error.message });
    }
  },
  getGraph: async (req, res) => {
    try {
      const tool_no = req.params.id;
      console.log(`Tool No: ${tool_no}`);

      // Langkah 1: Ambil history_id dari tool_no di v_tools_histories
      const conditionToolHistory = `WHERE tool_no = '${tool_no}'`;
      const toolHistories = await queryGET(
        "v_tools_histories",
        conditionToolHistory
      );

      if (toolHistories.length === 0) {
        return res
          .status(404)
          .json({ message: "No data found for the given tool number" });
      }

      // Filter history_id dengan system_activity = 'REGRINDING'
      const regrindingHistories = toolHistories.filter(
        (history) => history.system_activity === "REGRINDING"
      );

      if (regrindingHistories.length === 0) {
        return res.status(404).json({
          message: "No regrinding data found for the given tool number",
        });
      }

      // Langkah 2: Ambil data dari tb_r_tool_checks berdasarkan setiap history_id
      const toolChecks = [];
      for (const history of regrindingHistories) {
        const conditionToolChecks = `WHERE tool_history_id = '${history.tool_history_id}'`;
        const checks = await queryGET(tb_r_tool_checks, conditionToolChecks);
        toolChecks.push(...checks);
      }

      if (toolChecks.length === 0) {
        return res.status(404).json({
          message: "No tool check data found for the given history IDs",
        });
      }

      // Gabungkan data measuring_portion yang sama tetapi pisahkan nilainya
      const combinedData = {};
      toolChecks.forEach((check) => {
        if (!combinedData[check.measuring_portion]) {
          combinedData[check.measuring_portion] = {
            lower_limit: check.lower_limit,
            upper_limit: check.upper_limit,
            values: [],
          };
        }
        combinedData[check.measuring_portion].values.push(check.value_check);
      });

      res.status(200).json({
        message: "Success",
        data: combinedData,
      });
    } catch (error) {
      console.error(`Error fetching graph data: ${error.message}`);
      res.status(500).json({ message: `Server error: ${error.message}` });
    }
  },
  getRegrindingGraph: async (req, res) => {
    try {
      const parameter = req.params.period; // Mendapatkan parameter dari request
      console.log("Parameter:", parameter);

      let table = tb_r_tools_histories;
      let whereCond = "";
      let cols = ["*"];

      // Menentukan kondisi where berdasarkan parameter
      if (parameter === "day") {
        // const today = moment().format("YYYY-MM-DD");
        const today = moment().format("YYYY-MM-DD");
        console.log("Today:", today);

        whereCond = `WHERE system_activity = 'REGRINDING' AND DATE(created_dt) = '${today}'`;
      } else if (parameter === "month") {
        const startOfMonth = moment().startOf("month").format("YYYY-MM-DD");
        const endOfMonth = moment().endOf("month").format("YYYY-MM-DD");
        whereCond = `WHERE system_activity = 'REGRINDING' AND DATE(created_dt) BETWEEN '${startOfMonth}' AND '${endOfMonth}'`;
      } else {
        return res.status(400).json({ message: "Invalid parameter" });
      }

      // Menjalankan query
      const rows = await queryGET(table, whereCond, cols);

      if (rows.length === 0) {
        return res
          .status(404)
          .json({ message: "No data found for the given criteria" });
      }

      // Mengirimkan respons
      res.status(200).json({
        message: "Success",
        data: rows,
      });
    } catch (error) {
      console.error("Error fetching regrinding data:", error);
      res.status(500).json({ message: "Server error" });
    }
  },
};
