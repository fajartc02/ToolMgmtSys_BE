const { databasePool } = require("../../config/database");

module.exports = {
  getToolByToolId: async (req, res) => {
    try {
      const { tool_type_id, tool_id } = req.query;
      console.log("tool_type_id", tool_type_id);
      console.log("tool_id", tool_id);

      let q = `
        SELECT tmt.*, trt.*
        FROM tb_m_tool_types tmt
        JOIN tb_r_tools trt ON tmt.tool_type_id = trt.tool_type_id
        WHERE tmt.tool_type_id = $1 AND trt.tool_id = $2
      `;

      const client = await databasePool.connect();
      const result = await client.query(q, [tool_type_id, tool_id]);
      const dataTool = result.rows;

      client.release();
      res.status(200).json({
        message: "Success",
        data: dataTool,
      });
    } catch (error) {
      res.status(500).json({
        message: "Failed",
        error: error.message,
      });
    }
  },

  getToolByMachineId: async (req, res) => {
    try {
      const machine_id = req.query.machine_id;
      const distribution_id = req.query.distribution_id;

      console.log("machine_id", machine_id);
      console.log("distribution_id", distribution_id);

      let q = `
        SELECT p.*, t.tool_type_id 
        FROM tb_t_tools_positions p
        JOIN tb_r_tools t ON p.tool_id = t.tool_id
        WHERE p.machine_id = $1 
        AND p.distribution_id = $2
      `;

      const client = await databasePool.connect();
      const result = await client.query(q, [machine_id, distribution_id]);
      const dataTool = result.rows;
      console.log("dataTool", dataTool);

      res.status(200).json({
        message: "Success",
        data: dataTool,
      });

      client.release();
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },
};
