const {
  getQualityGraifk,
} = require("../../controllers/quality/quality.controller");

var router = require("express").Router();

router.get("/get", getQualityGraifk);

module.exports = router;
