const {
  getToolByLocation,
  getStdToolFCheck,
  getHistoryFCheck,
  addHasilToolFCheck,
  getMachineForToolChange,
  getToolNo,
  addHistoriesNoQr,
  editMachineFirstCheck,
  getToolNoForTable,
} = require("../../controllers/ToolbyLocation/toolByLocation.controller");

var router = require("express").Router();

router.get("/get", getToolByLocation);
router.get("/std", getStdToolFCheck);
router.post("/add", addHasilToolFCheck);
router.get("/history", getHistoryFCheck);
router.get("/search-machines", getMachineForToolChange);
router.get("/search-tools-no", getToolNo);
router.post("/history-tool-no-qr", addHistoriesNoQr);
router.put("/edit-machine", editMachineFirstCheck);
router.get("/get-tool-no", getToolNoForTable);

module.exports = router;
