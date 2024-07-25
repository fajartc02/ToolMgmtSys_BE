async function GENERATE_TOOL_NO(tool_type_id, db, tool_type_nm) {
    const tool_count = await db.query(
        `SELECT COUNT(tool_no) FROM tb_r_tools WHERE tool_type_id = ${tool_type_id}`
    );
    return tool_type_nm + "-" + (Number(tool_count.rows[0].count) + 1);
}

module.exports = GENERATE_TOOL_NO;