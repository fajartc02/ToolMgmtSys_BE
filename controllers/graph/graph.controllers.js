const { queryCustom } = require("../../helpers/query");
const { success, error } = require("../../helpers/response");
const moment = require("moment");

module.exports = {
  // getGraphRegrdindingCount: async (req, res) => {
  //   try {
  //     console.log("req.query masem", req.query);

  //     let data = [
  //       {
  //         name: "Actual",
  //         data: [],
  //       },
  //       {
  //         name: "Standard",
  //         data: [],
  //       },
  //     ];
  //     let categories = [];
  //     let annotations = {
  //       points: [],
  //     };

  //     let result = await queryCustom(`
  //         SELECT
  //           trt.tool_id,
  //           trt.std_counter,
  //           trth.*,
  //           DATE(trth.created_dt) AS created_date
  //         FROM tb_r_tools_histories trth
  //         JOIN tb_r_tools trt ON trt.tool_id = trth.tool_id
  //         WHERE trth.system_activity = '${req.query.system_activity}'
  //           AND trt.tool_qr = '${req.query.tool_qr}'
  //         ORDER BY trth.created_dt ASC
  //       `);

  //     await result.rows.map((item, i) => {
  //       categories.push(moment(item.created_dt).format("DD-MM-YYYY")); // Format tanggal

  //       // ACTUAL
  //       data[0].data.push(+item.act_counter);
  //       // STANDARD
  //       data[1].data.push(+item.std_counter);
  //       if (item.system_problem) {
  //         annotations.points.push({
  //           x: item.created_dt, // Gunakan created_date untuk anotasi
  //           y: +item.act_counter,
  //           marker: {
  //             size: 1,
  //           },
  //           label: {
  //             text: item.system_problem.split(" ").join("\n"),
  //             borderColor: "#ff0000",
  //             style: {
  //               background: "#ffd6d6",
  //               cssClass: "apexcharts-point-annotation-label",
  //             },
  //           },
  //         });
  //       }
  //     });
  //     console.log("ikilho", data);

  //     success(res, "Success", { data, categories, annotations });
  //   } catch (err) {
  //     console.log(err);
  //     error(res, "Error System");
  //   }
  // },

  getGraphRegrdindingCount: async (req, res) => {
    try {
      console.log("▶️ [QUERY PARAMS]", req.query);

      let data = [
        { name: "Actual", data: [] },
        { name: "Standard", data: [] },
      ];
      let categories = [];
      let annotations = { points: [] };

      const result = await queryCustom(`
      SELECT 
        trt.tool_id,
        trt.tool_no,
        trth.distribution_id,
        trth.act_counter,
        trth.system_problem,
        trth.created_dt,
        DATE(trth.created_dt) AS created_date
      FROM tb_r_tools_histories trth
      JOIN tb_r_tools trt ON trt.tool_id = trth.tool_id
      WHERE trth.system_activity = '${req.query.system_activity}' 
        AND trt.tool_qr = '${req.query.tool_qr}'
      ORDER BY trth.created_dt ASC
    `);

      console.log("✅ [RESULT] Jumlah histori:", result.rows.length);

      for (const item of result.rows) {
        const createdDate = moment(item.created_dt).format("DD-MM-YYYY");
        categories.push(createdDate);
        const act_counter = +item.act_counter;

        // 1. Mapping distribution_id ke line_id
        const distToLine = { 3: 0, 4: 2, 5: 3, 6: 1 };
        const line_id = distToLine[item.distribution_id] ?? null;
        console.log(
          "🧭 [line_id]",
          line_id,
          "dari distribution_id:",
          item.distribution_id
        );

        // 2. Ambil 5 digit dari tool_no
        const mid5 = item.tool_no.match(/\d{5}/)?.[0] || "";
        console.log("🔍 [mid5 dari tool_no]", mid5);

        // 3. Ambil machine_id dari tb_t_tools_positions
        const posRes = await queryCustom(`
        SELECT machine_id 
        FROM tb_t_tools_positions 
        WHERE tool_id = ${item.tool_id}
        LIMIT 1
      `);
        const machine_id = posRes.rows?.[0]?.machine_id;
        console.log("🛠️ [machine_id]", machine_id);

        // 4. Ambil op_no dari tb_m_machines
        let op_no = "";
        if (machine_id) {
          const machineRes = await queryCustom(`
          SELECT op_no 
          FROM tb_m_machines 
          WHERE machine_id = ${machine_id}
          LIMIT 1
        `);
          op_no = machineRes.rows?.[0]?.op_no.match(/\d+/)?.[0] || "";
        }
        console.log("🔧 [op_no]", op_no);

        // 5. Ambil std_ctr dari tb_m_master_tools_f_check
        let std_ctr = null;
        if (line_id !== null && mid5 && op_no) {
          const stdRes = await queryCustom(`
          SELECT std_ctr 
          FROM tb_m_master_tools_f_check
          WHERE line_id = ${line_id} AND op_no = '${op_no}'
          AND tool_nm ILIKE '%${mid5}%'
          LIMIT 1
        `);
          std_ctr = stdRes.rows?.[0]?.std_ctr || null;
        }
        console.log("📏 [std_ctr ditemukan]", std_ctr);

        // 6. Push data ke grafik
        data[0].data.push(act_counter);
        data[1].data.push(std_ctr ? +std_ctr : 0);

        // 7. Anotasi jika ada problem
        if (item.system_problem) {
          annotations.points.push({
            x: createdDate,
            y: act_counter,
            marker: { size: 1 },
            label: {
              text: item.system_problem.split(" ").join("\n"),
              borderColor: "#ff0000",
              style: {
                background: "#ffd6d6",
                cssClass: "apexcharts-point-annotation-label",
              },
            },
          });
        }
      }

      console.log("📊 [Final Data]", data);
      success(res, "Success", { data, categories, annotations });
    } catch (err) {
      console.error("❌ [ERROR getGraphRegrdindingCount]", err);
      error(res, "Error System");
    }
  },
};
