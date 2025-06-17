const {
  tb_r_tools_histories,
  tb_m_lines,
  tb_m_machines,
  tb_r_tools,
  tb_m_tools_f_check_std,
  tb_m_master_tools_f_check,
  tb_r_tool_f_chekcs,
  tb_r_histories_tool_no_qr,
} = require("../../config/table");
const {
  queryGET,
  queryTransaction,
  queryPOST,
  queryPUT,
  queryCustom,
  queryDELETE,
} = require("../../helpers/query");
const GET_LAST_ID = require("../../functions/GET_LAST_ID");
const queryCondExacOpAnd = require("../../helpers/queryCondExacOpAnd");
const { error, success } = require("../../helpers/response");
const getPaginatedData = require("../../functions/PAGINATION");
const moment = require("moment");
const condDataNotDeleted = `WHERE deleted_dt IS NULL`;

module.exports = {
  // getToolByLocation: async (req, res) => {
  //   try {
  //     const meta = req.query.meta; // Memeriksa apakah meta ada
  //     // console.log(req.query);

  //     const location = req.query.location;

  //     // Jika location adalah 'Tool Regrinding' atau 'Clean Room', kembalikan data kosong
  //     if (location === "Tool Regrinding" || location === "Clean Room") {
  //       return success(res, "No data available for this location", {
  //         data: [], // Data kosong
  //         meta: {
  //           currentPage: meta?.currentPage || 1,
  //           itemsPerPage: meta?.itemsPerPage || 10,
  //           totalData: 0,
  //         },
  //       });
  //     }

  //     // Step 1: Ambil line_id berdasarkan lokasi
  //     const lineCondition = `${condDataNotDeleted} AND line_nm = '${location}'`;
  //     const lineData = await queryGET(tb_m_lines, lineCondition, ["line_id"]);

  //     if (!lineData || lineData.length === 0) {
  //       return success(res, "No data found for the given location", []);
  //     }

  //     const lineIds = lineData.map((line) => line.line_id);

  //     // Step 2: Ambil machine_id dan machine_nm berdasarkan line_id
  //     const machineCondition = `${condDataNotDeleted} AND line_id IN (${lineIds.join(
  //       ","
  //     )})`;
  //     const machineData = await queryGET(tb_m_machines, machineCondition, [
  //       "machine_id",
  //       "machine_nm",
  //     ]);

  //     if (!machineData || machineData.length === 0) {
  //       return success(res, "No machines found for the given location", []);
  //     }

  //     const machineIds = machineData.map((machine) => machine.machine_id);

  //     // Step 3: Ambil data dari tb_r_tools_histories dengan atau tanpa pagination
  //     let toolHistoryCondition = `
  //           system_activity = 'IN USED'
  //           AND machine_id IN (${machineIds.join(",")})
  //         `;

  //     let toolHistories;
  //     if (meta) {
  //       // Jika meta ada, gunakan getPaginatedData untuk mengambil data dengan paginasi
  //       toolHistories = await getPaginatedData(
  //         tb_r_tools_histories,
  //         meta.currentPage,
  //         meta.itemsPerPage,
  //         toolHistoryCondition,
  //         "created_dt",
  //         null,
  //         null,
  //         false, // Menandakan kolom deleted_dt tidak digunakan (karena tabel tidak memiliki deleted_dt)
  //         "timestamp"
  //       );
  //     } else {
  //       // Jika meta tidak ada, ambil data tanpa paginasi
  //       toolHistories = await queryGET(
  //         tb_r_tools_histories,
  //         toolHistoryCondition + " ORDER BY created_dt DESC"
  //       );
  //     }

  //     // Step 4: Ambil tool_id dari toolHistories
  //     const toolIds = toolHistories.data.map((tool) => tool.tool_id);
  //     const uniqueToolIds = [...new Set(toolIds)]; // Menghilangkan duplikasi tool_id

  //     // Step 5: Ambil tool_no berdasarkan tool_id dari tb_r_tools
  //     const toolData = await queryGET(
  //       tb_r_tools,
  //       `tool_no WHERE tool_id IN (${uniqueToolIds.join(",")})`
  //     );

  //     const responseData = toolHistories.data.map((tool) => {
  //       const toolInfo = toolData.find((t) => t.tool_id === tool.tool_id);
  //       const machineInfo = machineData.find(
  //         (m) => m.machine_id === tool.machine_id
  //       );
  //       // Tambahkan log untuk melihat created_dt
  //       // console.log("tool.created_dt:", tool.created_dt);

  //       return {
  //         ...tool,
  //         tool_no: toolInfo ? toolInfo.tool_no : null,
  //         machine_nm: machineInfo ? machineInfo.machine_nm : null,
  //         created_dt: tool.created_dt,
  //       };
  //     });
  //     // console.log("responseData", responseData);

  //     // Kirim respons dengan data dan meta (jika ada)
  //     success(res, "Success", { ...toolHistories, data: responseData });
  //   } catch (err) {
  //     console.error(err);
  //     error(res, err.message);
  //   }
  // },
  getToolByLocation: async (req, res) => {
    try {
      const meta = req.query.meta;
      const machine_id = req.query.machine_id;
      const location = req.query.location;

      // Jika lokasi adalah 'Tool Regrinding' atau 'Clean Room', kembalikan data kosong
      if (location === "Tool Regrinding" || location === "Clean Room") {
        return success(res, "No data available for this location", {
          data: [],
          meta: {
            currentPage: meta?.currentPage || 1,
            itemsPerPage: meta?.itemsPerPage || 10,
            totalData: 0,
          },
        });
      }

      // Step 1: Ambil line_id berdasarkan lokasi
      const lineCondition = `${condDataNotDeleted} AND line_nm = '${location}'`;
      const lineData = await queryGET(tb_m_lines, lineCondition, ["line_id"]);

      if (!lineData || lineData.length === 0) {
        return success(res, "No data found for the given location", []);
      }

      const lineIds = lineData.map((line) => line.line_id);

      // Step 2: Ambil machine_id dan machine_nm berdasarkan line_id
      const machineCondition = `${condDataNotDeleted} AND line_id IN (${lineIds.join(
        ","
      )})`;
      const machineData = await queryGET(tb_m_machines, machineCondition, [
        "machine_id",
        "machine_nm",
      ]);

      if (!machineData || machineData.length === 0) {
        return success(res, "No machines found for the given location", []);
      }

      const machineIds = machineData.map((machine) => machine.machine_id);

      // Step 3: Ambil data dari tb_r_tools_histories dan tb_r_histories_tool_no_qr
      const toolHistoryCondition = `
        system_activity = 'IN USED' 
        AND machine_id IN (${machineIds.join(",")})
      `;

      let toolHistories = { data: [], meta: {} };
      let noQrHistories = { data: [], meta: {} };

      if (meta) {
        // Dengan pagination
        toolHistories = await getPaginatedData(
          tb_r_tools_histories,
          meta.currentPage,
          meta.itemsPerPage,
          toolHistoryCondition,
          "created_dt",
          null,
          null,
          false // Tidak ada deleted_dt
        );

        noQrHistories = await getPaginatedData(
          tb_r_histories_tool_no_qr,
          meta.currentPage,
          meta.itemsPerPage,
          toolHistoryCondition,
          "created_dt",
          null,
          null,
          false // Tidak ada deleted_dt
        );
      } else {
        // Tanpa pagination
        toolHistories = await queryGET(
          "tb_r_tools_histories",
          toolHistoryCondition + " ORDER BY created_dt DESC"
        );

        noQrHistories = await queryGET(
          "tb_r_histories_tool_no_qr",
          toolHistoryCondition + " ORDER BY created_dt DESC"
        );
      }

      // Step 4: Ambil tool_no dan tool_nm berdasarkan tool_id
      const uniqueToolIds = [
        ...new Set([
          ...toolHistories.data.map((tool) => tool.tool_id),
          ...noQrHistories.data.map((tool) => tool.tool_id),
        ]),
      ];

      let toolData = [];
      let toolNames = [];

      if (uniqueToolIds.length > 0) {
        toolData = await queryGET(
          tb_r_tools,
          `tool_no WHERE tool_id IN (${uniqueToolIds.join(",")})`
        );

        toolNames = await queryGET(
          "tb_m_master_tools_f_check",
          `tool_nm WHERE tool_id IN (${uniqueToolIds.join(",")})`
        );
      }

      // Proses untuk memastikan tool_histories memiliki tool_no dan machine_nm
      const processedToolHistories = toolHistories.data.map((tool) => {
        const toolInfo = toolData.find((t) => t.tool_id === tool.tool_id);
        const machineInfo = machineData.find(
          (m) => m.machine_id === tool.machine_id
        );
        return {
          ...tool,
          tool_qr: toolInfo ? toolInfo.tool_qr : null,
          tool_nm: toolInfo ? toolInfo.tool_no : null,
          machine_nm: machineInfo ? machineInfo.machine_nm : null, // Tambahkan machine_nm
        };
      });

      // Proses untuk memastikan noQrHistories memiliki tool_no dan machine_nm
      const processedNoQrHistories = noQrHistories.data.map((tool) => {
        const toolNameInfo = toolNames.find((t) => t.tool_id === tool.tool_id);
        const machineInfo = machineData.find(
          (m) => m.machine_id === tool.machine_id
        );
        return {
          ...tool,
          tool_nm: toolNameInfo ? toolNameInfo.tool_nm : null,
          machine_nm: machineInfo ? machineInfo.machine_nm : null, // Tambahkan machine_nm
        };
      });

      // Gabungkan data histories setelah memastikan tool_no dan machine_nm ada
      const responseData = [
        ...processedToolHistories,
        ...processedNoQrHistories,
      ];

      const sortedResponseData = responseData
        .map((item) => ({
          ...item,
          isoCreatedDt: item.created_dt.split("-").reverse().join("-"), // Properti sementara untuk sorting
        }))
        .sort((a, b) => new Date(b.isoCreatedDt) - new Date(a.isoCreatedDt)) // Urutkan
        .map(({ isoCreatedDt, ...rest }) => rest); // Hapus properti sementara

      // Tambahkan nomor urut unik (no)
      const uniqueResponseData = sortedResponseData.map((item, index) => ({
        ...item,
        no: index + 1,
      }));

      // Tambahkan logika filtering sebelum data dikirim ke FE
      let finalResponseData = uniqueResponseData;
      // console.log("machine_id dari FE", machine_id);

      // console.log("sample data", uniqueResponseData.slice(0, 3));
      // Jika tool_qr ada di query, filter hanya yang memiliki tool_qr
      if (machine_id !== undefined) {
        const machineIdNum = Number(machine_id);
        finalResponseData = uniqueResponseData.filter(
          (item) => item.machine_id === machineIdNum
        );
      }

      // Kirim respons dengan data dan meta
      success(res, "Success", {
        data: finalResponseData,
        meta: {
          currentPage: meta?.currentPage || 1,
          itemsPerPage: meta?.itemsPerPage || 10,
          totalData: finalResponseData.length,
        },
      });
    } catch (err) {
      console.error(err);
      error(res, err.message);
    }
  },

  getStdToolFCheck: async (req, res) => {
    try {
      const { tool_no, tool_nm, location, machine_id } = req.query;
      // console.log("req.query", req.query);

      // Validasi input
      if (!tool_no || !tool_nm || !location || !machine_id) {
        return res
          .status(400)
          .json({ message: "tool_no and location are required" });
      }
      // Ambil line_id berdasarkan location
      const lineCondition = `WHERE line_nm = '${location}'`; // Parameter dimasukkan langsung
      const lineResult = await queryGET(tb_m_lines, lineCondition, ["line_id"]);

      if (!lineResult.length) {
        return res
          .status(404)
          .json({ message: "Line not found for the given location" });
      }
      const line_id = lineResult[0].line_id;
      // console.log("line_id", line_id);

      // Ambil op_no berdasarkan machine_id
      const opCondition = `WHERE machine_id = '${machine_id}'`;

      const opResult = await queryGET(tb_m_machines, opCondition, ["op_no"]);
      if (!opResult.length) {
        return res
          .status(404)
          .json({ message: "Operation not found for the given machine_id" });
      }
      const rawOpNo = opResult[0].op_no;
      const op_no = rawOpNo.replace(/[A-Za-z]+$/, "");

      // console.log("op_no", op_no);

      // Ambil tool_id berdasarkan tool_no dan line_id
      const toolCondition = `
                              WHERE line_id = '${line_id}' AND tool_no = '${tool_no}' AND op_no = '${op_no}'
                            `;

      const toolResult = await queryGET(
        tb_m_master_tools_f_check,
        toolCondition,
        ["tool_id"]
      );

      if (!toolResult.length) {
        return res.status(404).json({
          message: "Tool not found for the given tool_no and line_id",
        });
      }
      const tool_id = toolResult[0].tool_id;
      // console.log("tool_id", tool_id);

      // Ambil data dari tb_m_tools_f_check_std berdasarkan tool_id
      const stdCondition = `WHERE tool_id = '${tool_id}' AND deleted_dt IS NULL ORDER BY tool_f_check_std_id ASC`;
      const stdResult = await queryGET(tb_m_tools_f_check_std, stdCondition);

      if (!stdResult.length) {
        return res
          .status(404)
          .json({ message: "No standard data found for the given tool_id" });
      }
      // console.log("stdResult", stdResult);

      // Return data
      res.status(200).json({ message: "Success", data: stdResult });
    } catch (error) {
      console.error("Error in getStdToolFCheck:", error.message); // Log error
      res.status(500).json({ message: error.message });
    }
  },
  addHasilToolFCheck: async (req, res) => {
    try {
      // console.log("req.body", req.body);
      // Validasi request body
      if (!Array.isArray(req.body) || req.body.length === 0) {
        throw new Error("Request body must be an array of measurements");
      }

      await queryTransaction(async (db) => {
        for (const measurement of req.body) {
          // Validasi field wajib
          if (
            !measurement.tool_id ||
            !measurement.measuring_portion ||
            !measurement.status
          ) {
            throw new Error(
              "Missing required fields: tool_id, measuring_portion, status"
            );
          }

          // Persiapkan data untuk disimpan
          const cleanMeasurement = {
            tool_id: measurement.tool_id,
            tool_f_check_std_id: measurement.tool_f_check_std_id,
            tool_history_id: measurement.tool_history_id,
            no_work: measurement.no_work || null,
            measuring_portion: measurement.measuring_portion,
            value_check: measurement.value_check,
            upper_limit: measurement.upper_limit || null,
            lower_limit: measurement.lower_limit || null,
            status: measurement.status,
            is_checked: "true",
            created_by: measurement.pic_check || null,
            created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
            deleted_by: null,
            deleted_dt: null,
            tool_no: measurement.tool_no,
          };

          // Ambil ID terakhir untuk tool_f_check_id
          const tool_f_check_id = await GET_LAST_ID(
            "tool_f_check_id",
            tb_r_tool_f_chekcs
          );

          const newMeasurement = {
            tool_f_check_id,
            ...cleanMeasurement,
          };

          // Tambahkan data baru
          await queryPOST(tb_r_tool_f_chekcs, newMeasurement);
        }

        // Respon sukses
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

  getHistoryFCheck: async (req, res) => {
    try {
      const { location } = req.query;

      // Validasi input
      if (!location) {
        return res.status(400).json({ message: "Location is required" });
      }

      // Ambil line_id berdasarkan location
      const lineCondition = `WHERE line_nm = '${location}'`;
      const lineResult = await queryGET(tb_m_lines, lineCondition, ["line_id"]);

      if (!lineResult.length) {
        return res
          .status(404)
          .json({ message: "Line not found for the given location" });
      }

      const line_id = lineResult[0].line_id;

      // Ambil tool_id berdasarkan line_id
      const toolCondition = `WHERE line_id = '${line_id}'`;
      const toolResult = await queryGET(
        tb_m_master_tools_f_check,
        toolCondition,
        ["tool_id"]
      );

      if (!toolResult.length) {
        return res.status(404).json({
          message: "Tool not found for the given line_id",
        });
      }

      const toolIds = toolResult.map((tool) => tool.tool_id);

      // Ambil data dari tb_r_tool_f_checks
      const stdCondition = `WHERE tool_id IN (${toolIds
        .map((id) => `'${id}'`)
        .join(",")})`;
      const stdResult = await queryGET(tb_r_tool_f_chekcs, stdCondition);

      if (!stdResult.length) {
        return res.status(200).json({
          message: "No standard data found for the given tool_id(s)",
          data: [],
        });
      }

      // 🔁 Dapatkan semua tool_f_check_std_id dari hasil di atas
      const stdIds = stdResult.map((item) => item.tool_f_check_std_id);
      console.log("stdIds", stdIds);

      // Buat kondisi SQL gabungan
      const stdToolCondition = `
            WHERE tool_id IN (${toolIds.map((id) => `'${id}'`).join(",")})
              AND tool_f_check_std_id IN (${stdIds
                .map((id) => `'${id}'`)
                .join(",")})
          `;
      const stdToolResult = await queryGET(
        tb_m_tools_f_check_std,
        stdToolCondition,
        ["tool_id", "tool_f_check_std_id", "gauge", "qty_check"]
      );

      const mergedResult = stdResult.map((stdItem) => {
        const toolData = stdToolResult.find(
          (toolItem) =>
            toolItem.tool_f_check_std_id === stdItem.tool_f_check_std_id
        );
        return {
          ...stdItem,
          gauge: toolData ? toolData.gauge : null,
          qty_check: toolData ? toolData.qty_check : null,
        };
      });
      // Return data
      res.status(200).json({ message: "Success", data: mergedResult });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error.message });
    }
  },
  getMachineForToolChange: async (req, res) => {
    try {
      const location = req.query.location;
      // console.log("location", location);

      const lineCondition = `WHERE line_nm = '${location}'`;
      const lineResult = await queryGET(tb_m_lines, lineCondition, ["line_id"]);
      if (!lineResult.length) {
        return res
          .status(403)
          .json({ message: "Line not found for the given location" });
      }
      const line_id = lineResult[0].line_id;

      const machineCondition = `WHERE line_id = '${line_id}'`;
      const machineResult = await queryGET(tb_m_machines, machineCondition);
      // console.log("machineResult", machineResult);

      res.status(200).json({ message: "Success", data: machineResult });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "error" });
    }
  },
  getToolNo: async (req, res) => {
    try {
      const location = req.query.location;
      const op_no = req.query.op_no;
      // console.log("tool_no", op_no);

      // Ambil line_id berdasarkan lokasi
      const lineCondition = `WHERE line_nm = '${location}'`;
      const lineResult = await queryGET(tb_m_lines, lineCondition, ["line_id"]);
      if (!lineResult.length) {
        return res
          .status(403)
          .json({ message: "Line not found for the given location" });
      }
      const line_id = lineResult[0].line_id;

      // Ambil semua data tool_no
      const toolNoCondition = `WHERE line_id = '${line_id}' AND op_no = '${op_no}'`;
      const tool_no = await queryGET(
        tb_m_master_tools_f_check,
        toolNoCondition
      );

      if (!tool_no.length) {
        return res
          .status(403)
          .json({ message: "Tool not found for the given tool_no" });
      }

      // Cek apakah semua tool_no memiliki format `T<number>`
      const isAllValidFormat = tool_no.every((item) =>
        /^T\d+$/.test(item.tool_no)
      );

      // Jika semua valid, urutkan; jika tidak, biarkan urutan aslinya
      const sortedToolNo = isAllValidFormat
        ? tool_no.sort((a, b) => {
            const numA = parseInt(a.tool_no.substring(1), 10);
            const numB = parseInt(b.tool_no.substring(1), 10);
            return numA - numB;
          })
        : tool_no;

      // console.log("sortedToolNo", sortedToolNo);

      res.status(200).json({ message: "Success", data: sortedToolNo });
    } catch (error) {
      console.error("Error:", error.message);
      res.status(500).json({ message: "Internal server error" });
    }
  },
  addHistoriesNoQr: async (req, res) => {
    try {
      const data = req.body;

      // Validasi data jika diperlukan
      if (!data.tool_id || !data.machine_id || !data.pic) {
        return res.status(400).json({ message: "Missing required fields" });
      }

      // Ambil ID berikutnya untuk `tool_history_id`
      const tool_history_id = await GET_LAST_ID(
        "tool_history_id",
        tb_r_histories_tool_no_qr
      );

      // Masukkan data ke tabel `tb_r_histories_tool_no_qr`
      const insertData = {
        tool_history_id, // Gunakan ID yang di-generate
        system_activity: data.system_activity,
        tool_id: data.tool_id,
        pic_check: data.pic,
        created_dt: moment().format("YYYY-MM-DD HH:mm:ss"),
        distribution_id: data.distribution_id,
        machine_id: data.machine_id,
        act_ctr: data.act_ctr || 0,
        system_problem: data.problem || null,
      };

      await queryPOST(tb_r_histories_tool_no_qr, insertData);

      res.status(201).json({
        message: "Data berhasil disimpan ke tb_r_histories_tool_no_qr",
        data: insertData,
      });
    } catch (error) {
      console.error("Error saving data:", error);
      res.status(500).json({ message: "Internal server error", error });
    }
  },
  editMachineFirstCheck: async (req, res) => {
    try {
      const { payload } = req.body;
      const {
        old_machine_id,
        new_machine_id,
        tool_qr,
        system_activity,
        location,
      } = payload;

      // console.log("🟡 Payload diterima:", payload);

      // 1. Validasi lokasi ke distribution_id
      const distributionMap = {
        "Cylinder Head": 8,
        "Cam Shaft": 7,
        "Cylinder Block": 9,
        "Crank Shaft": 10,
      };

      const distribution_id = distributionMap[location];
      if (!distribution_id) {
        throw new Error("Invalid location provided");
      }

      // 2. Ambil tool_type_id berdasarkan tool_qr
      const toolResult = await queryGET(
        "tb_r_tools",
        `WHERE tool_qr = '${tool_qr}'`,
        ["tool_type_id"]
      );

      if (!toolResult.length) {
        throw new Error("Tool not found based on tool_qr");
      }

      const tool_type_id = toolResult[0].tool_type_id;
      // console.log("✅ tool_type_id:", tool_type_id);

      // 3. Ambil semua tool_id dengan tool_type_id yang sama
      const relatedTools = await queryGET(
        "tb_r_tools",
        `WHERE tool_type_id = ${tool_type_id}`,
        ["tool_id"]
      );

      const relatedToolIds = relatedTools.map((t) => parseInt(t.tool_id));
      // console.log("✅ relatedToolIds:", relatedToolIds);

      if (!relatedToolIds.length) {
        throw new Error("No tools found for this type");
      }

      // 4. Ambil satu data terakhir yang USED dari mesin lama
      const relatedToolIdsStr = `(${relatedToolIds.join(",")})`;
      const historyQuery = `
  SELECT tool_history_id, tool_id 
  FROM tb_r_tools_histories 
  WHERE system_activity = 'USED' 
    AND machine_id = ${old_machine_id}
    AND tool_id IN ${relatedToolIdsStr}
  ORDER BY created_dt DESC
  LIMIT 1
`;

      const usedHistory = await queryCustom(historyQuery);
      // console.log("✅ USED History Found:", usedHistory);

      if (!usedHistory?.rows?.length) {
        return res
          .status(200)
          .json({ message: "No matching USED tool history found" });
      }

      const { tool_history_id, tool_id: used_tool_id } = usedHistory.rows[0];

      // lanjut delete dan update seperti biasa
      await queryDELETE(
        "tb_r_tools_histories",
        `WHERE tool_history_id = ${tool_history_id}`
      );
      await queryPUT(
        "tb_t_tools_positions",
        { distribution_id },
        `WHERE tool_id = ${used_tool_id}`
      );
      await queryPUT(
        "tb_t_tools_positions",
        { machine_id: new_machine_id },
        `WHERE tool_id = ${payload.tool_id}`
      );
      await queryPUT(
        "tb_r_tools_histories",
        {
          machine_id: new_machine_id,
        },
        `WHERE tool_history_id = ${payload.tool_history_id}`
      );
      // 5. Cari tool_id yang sudah USED di mesin baru dan masih 1 tool_type_id
      const historyUsedNewMachineQuery = `
                                SELECT tool_id 
                                FROM tb_r_tools_histories 
                                WHERE system_activity = '${system_activity}'
                                  AND machine_id = ${new_machine_id}
                                  AND tool_id IN ${relatedToolIdsStr}
                                ORDER BY created_dt DESC
                                LIMIT 1
                              `;

      const usedInNewMachine = await queryCustom(historyUsedNewMachineQuery);

      if (!usedInNewMachine?.rows?.length) {
        throw new Error("No USED tools found in new machine for this type");
      }

      const target_tool_id = usedInNewMachine.rows[0].tool_id;
      // Ambil ID terakhir untuk tool_f_check_id
      const new_tool_history_id = await GET_LAST_ID(
        "tool_history_id",
        "tb_r_tools_histories"
      );

      // Buat entri baru untuk tool tersebut
      await queryPOST("tb_r_tools_histories", {
        tool_history_id: new_tool_history_id,
        tool_id: target_tool_id,
        machine_id: new_machine_id,
        system_activity: "USED",
      });

      res.status(200).json({ message: "Success" });
    } catch (error) {
      console.error("❌ editMachineFirstCheck error:", error.message);
      res.status(500).json({
        message: "Something went wrong",
        detail: error.message,
      });
    }
  },
  getToolNoForTable: async (req, res) => {
    try {
      const location = req.query.location;
      console.log("location", location);

      // Map lokasi ke line_id
      const lineMap = {
        "Cam Shaft": 0,
        "Crank Shaft": 1,
        "Cylinder Head": 2,
        "Cylinder Block": 3,
      };

      const line_id = lineMap[location];

      if (line_id === undefined) {
        return res.status(400).json({
          message: "Invalid location",
        });
      }

      // Ambil data tools berdasarkan line_id
      const toolResult = await queryGET(
        "tb_m_master_tools_f_check",
        `WHERE line_id = ${line_id}`
      );

      res.status(200).json({ message: "Success", data: toolResult });
    } catch (error) {
      console.error("❌ getToolNoForTable error:", error.message);
      res.status(500).json({
        message: "Something went wrong",
        detail: error.message,
      });
    }
  },
};
