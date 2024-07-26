const {
  getLines,
  addLine,
  deleteLine,
} = require("../../controllers/lines/lines.controller");

var router = require("express").Router();

router.get("/get", getLines);

router.post("/add", addLine);

router.put("/delete/:id", deleteLine);

module.exports = router;
