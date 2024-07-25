const {
    submitToolHistory,
    getToolHistories,
} = require("../../controllers/tools/tool_histories.controllers");
const {
    getTools,
    generateToolQR,
    addTool,
    updatePos,
} = require("../../controllers/tools/tools.controllers");
const {
    getToolByQR,
} = require("../../controllers/tools/tools_positions.controllers");

const router = require("express").Router();

router.get("/get", getTools);
router.get("/details", getToolByQR);
router.get("/generateQR", generateToolQR);

router.post("/add", addTool);
router.get("/history", getToolHistories);
router.post("/history", submitToolHistory);

router.put("/position", updatePos);

module.exports = router;