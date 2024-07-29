const {
  getLines,
  addLine,
  deleteLine,
  editLine,
} = require("../../controllers/lines/lines.controller");

var router = require("express").Router();

router.get("/get", getLines);
router.post("/add", addLine);
router.put("/delete/:id", deleteLine);
router.put("/edit/:id", editLine);

module.exports = router;
