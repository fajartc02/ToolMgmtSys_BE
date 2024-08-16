const {
  getRegrinding,
  getGraph,
  getRegrindingGraph,
} = require("../../controllers/HistoryReg/regrinding.controller");

var router = require("express").Router();

router.get("/get", getRegrinding);
router.get("/graph/:id", getGraph);
router.get("/graphReg/:period", getRegrindingGraph);

module.exports = router;
