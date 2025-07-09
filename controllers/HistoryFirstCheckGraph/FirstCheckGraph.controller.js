const { queryGET } = require("../../helpers/query");
const {
  tb_r_tool_f_chekcs,
  tb_m_tools_f_check_std,
} = require("../../config/table");
const { error, success } = require("../../helpers/response");
const moment = require("moment");
module.exports = {
  getGraphFirstCheck: async (req, res) => {
    try {
      const tool_no = req.params.id;
      console.log("Tool No:", tool_no);

      // 1. Ambil data dari tb_r_tool_f_checks berdasarkan tool_no
      const conditionToolChecks = `WHERE tool_no = '${tool_no}'`;
      const toolChecks = await queryGET(
        tb_r_tool_f_chekcs,
        conditionToolChecks
      );

      if (toolChecks.length === 0) {
        return res.status(200).json({
          data: [],
          message: "No tool check data found for the given tool_no",
        });
      }

      // 2. Ambil semua tool_f_check_std_id unik
      const uniqueStdIds = [
        ...new Set(toolChecks.map((item) => item.tool_f_check_std_id)),
      ];
      const stdIdList = uniqueStdIds.map((id) => `'${id}'`).join(", ");
      const stdCondition = `WHERE tool_f_check_std_id IN (${stdIdList})`;

      const stdRefs = await queryGET(tb_m_tools_f_check_std, stdCondition);

      // 3. Buat map: tool_f_check_std_id -> detail gauge dan limit
      const stdMap = {};
      stdRefs.forEach((item) => {
        stdMap[item.tool_f_check_std_id] = {
          gauge: item.gauge,
          upper_limit: item.upper_limit,
          lower_limit: item.lower_limit,
        };
      });

      // 4. Gabungkan berdasarkan measuring_portion + std_id
      const combinedMap = toolChecks.reduce((acc, check) => {
        const stdInfo = stdMap[check.tool_f_check_std_id] || {};
        const key = `${check.measuring_portion}___${check.tool_f_check_std_id}`;

        if (!acc[key]) {
          acc[key] = {
            measuring_portion: check.measuring_portion,
            gauge: stdInfo.gauge || null,
            lower_limit: null,
            upper_limit: null,
            values: [],
          };
        }

        const isNumeric =
          check.value_check?.trim() !== "" &&
          !isNaN(parseFloat(check.value_check));

        // Set limit jika value angka dan belum di-set
        if (
          isNumeric &&
          acc[key].lower_limit === null &&
          acc[key].upper_limit === null
        ) {
          acc[key].lower_limit = stdInfo.lower_limit;
          acc[key].upper_limit = stdInfo.upper_limit;
        }

        acc[key].values.push({
          value: check.value_check,
          created_dt: check.created_dt,
          no_work: check.no_work,
        });

        return acc;
      }, {});

      // 5. Urutkan values per group berdasarkan created_dt
      Object.values(combinedMap).forEach((portionGroup) => {
        portionGroup.values.sort(
          (a, b) => new Date(a.created_dt) - new Date(b.created_dt)
        );
      });

      // 6. Kirim data sebagai array
      res.status(200).json({
        data: Object.values(combinedMap),
        message: "Success",
      });
    } catch (error) {
      console.error("Error in getGraphFirstCheck:", error);
      res.status(500).json({ message: "Error", error: error.message });
    }
  },
};
