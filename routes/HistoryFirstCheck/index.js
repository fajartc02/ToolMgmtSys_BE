const {
  getGraphFirstCheck,
} = require("../../controllers/HistoryFirstCheckGraph/FirstCheckGraph.controller");

var router = require("express").Router();

router.get("/get/:id", getGraphFirstCheck);
module.exports = router;
