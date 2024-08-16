const {
  getSetting,
  getMeasuringGraph,
  getSettingGraph,
} = require("../../controllers/HistorySeting/setting.controller");

var router = require("express").Router();

router.get("/get", getSetting);
router.get("/measureGraph/:id", getMeasuringGraph);
router.get("/measureGraphSet/:period", getSettingGraph);

module.exports = router;
