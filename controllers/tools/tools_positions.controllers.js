const { error, success, notFound } = require("../../helpers/response");
const {
  tb_r_tools,
  tb_t_tools_positions,
  tb_m_distributions,
  tb_m_tool_types,
  tb_m_machines,
  tb_r_tools_histories,
} = require("../../config/table");
const { queryCustom } = require("../../helpers/query");

module.exports = {
  //   getToolByQR: async (req, res) => {
  //     try {
  //       console.log("reg query", req.query);
  //       if (!machine_id) {
  //         const result = await queryCustom(
  //           `SELECT
  //                       ${tb_t_tools_positions}.*,
  //                       ${tb_r_tools}.tool_no,
  //                       ${tb_r_tools}.tool_qr,
  //                       ${tb_m_tool_types}.tool_type_id,
  //                       ${tb_m_machines}.machine_id,
  //                       ${tb_m_machines}.machine_nm,
  //                       coalesce(${tb_m_tool_types}.tool_type_desc, 'Tidak Ada Deskripsi') AS tool_type_desc,
  //                       ${tb_m_distributions}.distribution_nm as position,
  //                       ${tb_m_tool_types}.std_counter as std_counter
  //                   FROM ${tb_t_tools_positions}
  //                   INNER JOIN ${tb_r_tools} ON ${tb_t_tools_positions}.tool_id = ${tb_r_tools}.tool_id
  //                   INNER JOIN ${tb_m_tool_types} ON ${tb_r_tools}.tool_type_id = ${tb_m_tool_types}.tool_type_id
  //                   INNER JOIN ${tb_m_distributions} ON ${tb_m_distributions}.distribution_id = ${tb_t_tools_positions}.distribution_id
  //                   LEFT JOIN ${tb_m_machines} ON ${tb_m_machines}.machine_id = ${tb_t_tools_positions}.machine_id
  //                   WHERE ${tb_t_tools_positions}.tool_id = (SELECT tool_id FROM ${tb_r_tools} WHERE tool_qr = '${req.query.tool_qr}')
  //                   `
  //         );
  //       } else {
  //       }

  //       if (result.rows.length == 0) {
  //         success(res, "Success", null);
  //         return;
  //       }
  //       success(res, "Success", result.rows);
  //     } catch (err) {
  //       console.log(err);
  //       error(res, err);
  //     }
  //   },

  getToolByQR: async (req, res) => {
    try {
      const { tool_qr } = req.query;

      console.log("tool_qr dari FE:", tool_qr);

      const result = await queryCustom(`SELECT
      ${tb_t_tools_positions}.*,
      ${tb_r_tools}.tool_no,
      ${tb_r_tools}.tool_qr,
      ${tb_m_tool_types}.tool_type_id,
      ${tb_m_tool_types}.tool_type_nm,
      ${tb_m_machines}.machine_id,
      ${tb_m_machines}.machine_nm,
      coalesce(${tb_m_tool_types}.tool_type_desc, 'Tidak Ada Deskripsi') AS tool_type_desc,
      ${tb_m_distributions}.distribution_nm as position,
      ${tb_m_tool_types}.std_counter as std_counter
    FROM ${tb_t_tools_positions}
    INNER JOIN ${tb_r_tools} ON ${tb_t_tools_positions}.tool_id = ${tb_r_tools}.tool_id
    INNER JOIN ${tb_m_tool_types} ON ${tb_r_tools}.tool_type_id = ${tb_m_tool_types}.tool_type_id
    INNER JOIN ${tb_m_distributions} ON ${tb_m_distributions}.distribution_id = ${tb_t_tools_positions}.distribution_id
    LEFT JOIN ${tb_m_machines} ON ${tb_m_machines}.machine_id = ${tb_t_tools_positions}.machine_id
    WHERE ${tb_t_tools_positions}.tool_id = (
      SELECT tool_id FROM ${tb_r_tools} WHERE tool_qr = '${tool_qr}'
    )
    `);

      console.log("Hasil query utama:", result.rows);

      if (result.rows.length === 0) {
        return success(res, "Success", null);
      }

      const tool = result.rows[0];

      // Ubah tool_type_nm → lowercase dan hapus spasi
      const normalizedToolType = tool.tool_type_nm
        ?.toLowerCase()
        .replace(/\s+/g, "");

      console.log("Normalized tool_type_nm untuk LIKE:", normalizedToolType);

      const stdResult = await queryCustom(`
      SELECT std_ctr FROM tb_m_master_tools_f_check
      WHERE REPLACE(LOWER(tool_nm), ' ', '') LIKE '${normalizedToolType}%'
      ORDER BY tool_nm ASC
      LIMIT 1
    `);

      console.log("Hasil query std_ctr:", stdResult.rows);

      if (stdResult.rows.length > 0) {
        tool.std_counter = stdResult.rows[0].std_ctr;
      } else {
        console.warn("std_ctr tidak ditemukan di tb_m_master_tools_f_check");
      }

      success(res, "Success", tool);
    } catch (err) {
      console.error("Terjadi error:", err);
      error(res, err);
    }
  },
};
