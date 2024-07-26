var express = require("express");
var router = express.Router();

router.use("/tool-types", require("./tool-types"));
router.use("/tools", require("./tools"));
router.use("/distributions", require("./distributions"));
router.use("/machines", require("./machines"));
router.use("/systems", require("./systems"));
router.use("/graph", require("./graph"));
router.use("/users", require("./users"));

module.exports = router;