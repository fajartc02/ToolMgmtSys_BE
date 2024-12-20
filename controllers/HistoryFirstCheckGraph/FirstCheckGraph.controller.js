const { queryGET } = require("../../helpers/query");
const { tb_r_tool_f_chekcs } = require("../../config/table");
const { error, success } = require("../../helpers/response");
const moment = require("moment");
module.exports = {
  getGraphFirstCheck: async (req, res) => {
    try {
      const tool_no = req.params.id; // Ambil tool_no dari parameter
      console.log("Tool No:", tool_no);

      // Langkah 1: Ambil data dari tb_r_tool__f_checks berdasarkan tool_no
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

      // Langkah 2: Gabungkan data berdasarkan measuring_portion
      const combinedData = toolChecks.reduce((acc, check) => {
        const portion = check.measuring_portion; // Measuring portion

        // Pastikan ada measuring_portion di dalam akumulasi
        if (!acc[portion]) {
          acc[portion] = {
            lower_limit: check.lower_limit,
            upper_limit: check.upper_limit,
            values: [], // Menyimpan data terkait measuring portion
          };
        }

        // Tambahkan objek ke values
        acc[portion].values.push({
          value: check.value_check, // Nilai pengecekan
          created_dt: check.created_dt, // Tanggal pencatatan
          no_work: check.no_work, // Nomor work
        });

        return acc;
      }, {});

      // Langkah 3: Urutkan values berdasarkan created_dt di setiap measuring_portion
      Object.keys(combinedData).forEach((portion) => {
        combinedData[portion].values.sort((a, b) => {
          return new Date(a.created_dt) - new Date(b.created_dt); // Urutkan berdasarkan tanggal
        });
      });

      // Langkah 4: Kirimkan respons
      res.status(200).json({ data: combinedData, message: "Success" });
    } catch (error) {
      console.error("Error in getGraphFirstCheck:", error);
      res.status(500).json({ message: "Error", error: error.message });
    }
  },
};
