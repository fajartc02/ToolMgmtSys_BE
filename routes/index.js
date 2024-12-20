var express = require("express");
var router = express.Router();

router.use("/tool-types", require("./tool-types"));
router.use("/tools", require("./tools"));
router.use("/distributions", require("./distributions"));
router.use("/machines", require("./machines"));
router.use("/systems", require("./systems"));
router.use("/graph", require("./graph"));

router.use("/lines", require("./lines"));
router.use("/users", require("./users"));
router.use("/regrinding", require("./historyReg"));
router.use("/setting", require("./historySetting"));
router.use("/scrab", require("./scrab"));
router.use("/grafik", require("./quality"));
router.use("/master-tool", require("./masterTool"));
router.use("/std-f-check", require("./stdCheck"));
router.use("/tools-by-location", require("./ToolByLocation"));
router.use("/first-check-history", require("./HistoryFirstCheck"));
router.use("/auth", require("./authRoutes"));

module.exports = router;
