const { queryCustom } = require("../../helpers/query");
const { success, error } = require("../../helpers/response");

module.exports = {
    getGraphRegrdindingCount: async(req, res) => {
        try {
            let data = [{
                    name: "Actual",
                    data: [],
                },
                {
                    name: "Standard",
                    data: [],
                },
            ];
            let categories = [];
            let annotations = {
                points: [],
            };

            let result = await queryCustom(`SELECT 
	trt.tool_id,
	trt.std_counter,
	trth.* 
FROM tb_r_tools_histories trth
join tb_r_tools trt on trt.tool_id = trth.tool_id
where system_activity = '${req.query.system_activity}' 
AND trth.tool_id = (SELECT tool_id FROM tb_r_tools WHERE tool_qr = '${req.query.tool_qr}')`);
            await result.rows.map((item, i) => {
                categories.push(`${item.system_activity.slice(0, 3)}-${i + 1}`);
                // ACTUAL
                data[0].data.push(+item.act_counter);
                // STANDARD
                data[1].data.push(+item.std_counter);
                if (item.system_problem) {
                    annotations.points.push({
                        x: `${item.system_activity.slice(0, 3)}-${i + 1}`,
                        y: +item.act_counter,
                        marker: {
                            size: 1,
                        },
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
            });
            success(res, "Success", { data, categories, annotations });
        } catch (err) {
            console.log(err);
            error(res, "Error System");
        }
    },
};