const { getScrab } = require("../../controllers/scrab/historyScrab.controller");

var router = require("express").Router();

router.get("/get", getScrab);

module.exports = router;
