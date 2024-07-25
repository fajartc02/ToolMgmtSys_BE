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
    getToolByQR: async(req, res) => {
        try {
            const result = await queryCustom(
                `SELECT 
                    ${tb_t_tools_positions}.*,
                    ${tb_r_tools}.tool_no,
                    ${tb_r_tools}.tool_qr,
                    ${tb_m_tool_types}.tool_type_id,
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
                WHERE ${tb_t_tools_positions}.tool_id = (SELECT tool_id FROM ${tb_r_tools} WHERE tool_qr = '${req.query.tool_qr}')
                `
            );

            if (result.rows.length == 0) {
                success(res, "Success", null);
                return;
            }
            success(res, "Success", result.rows);
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
};