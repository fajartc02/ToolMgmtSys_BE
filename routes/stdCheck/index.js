const {
  addSdtFCheck,
  getStdFCheck,
  deleteStdFCheck,
} = require("../../controllers/stdFCheck/stdFCheck.controller");

var router = require("express").Router();

router.post("/add", addSdtFCheck);
router.get("/get", getStdFCheck);
router.delete("/delete/:id", deleteStdFCheck);

module.exports = router;
