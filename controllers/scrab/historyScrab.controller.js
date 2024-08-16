const { error, success } = require("../../helpers/response");
const { tb_r_tools, tb_r_tools_histories } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
  getScrab: async (req, res) => {
    try {
      let meta = req.query.meta;
      let result;

      if (meta) {
        result = await getPaginatedData(
          tb_r_tools_histories,
          meta.currentPage,
          meta.itemsPerPage,
          `system_activity = 'SCRAB'`,
          "tool_history_id",
          null,
          false
        );
      } else {
        result = await queryGET(
          tb_r_tools_histories,
          `system_activity = 'SCRAB'`
        );
      }

      const toolIds = result.data.map((history) => history.tool_id);

      if (toolIds.length > 0) {
        const tools = await queryGET(
          `${tb_r_tools} WHERE tool_id IN (${toolIds.join(",")})`
        );

        const combinedResult = result.data.map((history) => {
          const tool = tools.find((tool) => tool.tool_id === history.tool_id);
          return {
            ...history,
            tool_no: tool ? tool.tool_no : null,
            tool_qr: tool ? tool.tool_qr : null,
            std_counter: tool ? tool.std_counter : null,
          };
        });

        success(res, "Success", { ...result, data: combinedResult });
      } else {
        success(res, "Success", result);
      }
    } catch (err) {
      console.log(err);
      error(res, "Failed to retrieve SCRAB data", err);
    }
  },
};
