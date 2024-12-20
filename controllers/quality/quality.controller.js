const { tb_r_tool_checks } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const moment = require("moment");

module.exports = {
  getQualityGraifk: async (req, res) => {
    try {
      const tool_qr = req.query.tool_qr;
      console.log(`Tool qr: ${tool_qr}`);

      // Langkah 1: Ambil history_id dari tool_qr di v_tools_histories
      const conditionToolHistory = `WHERE tool_qr = '${tool_qr}'`;
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
        // Sertakan date_check dari history ke dalam setiap hasil tool_check
        checks.forEach((check) => {
          check.date_check = history.date_check; // Tambahkan date_check dari v_tools_histories
        });

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
            dates: [],
          };
        }
        combinedData[check.measuring_portion].values.push(check.value_check);
        combinedData[check.measuring_portion].dates.push(
          moment(check.date_check).format("DD-MM-YYYY")
        );
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
};
