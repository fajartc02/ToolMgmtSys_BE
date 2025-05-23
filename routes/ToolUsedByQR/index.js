const {
  getToolByMachineId,
  getToolByToolId,
} = require("../../controllers/ToolUsedByQR/toolUsedByQR.controller");

var router = require("express").Router();

router.get("/get", getToolByToolId);
router.get("/get-tool", getToolByMachineId);
module.exports = router;
