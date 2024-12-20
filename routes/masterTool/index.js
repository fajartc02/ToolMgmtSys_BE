const {
  getMasterTool,
  addMasterTool,
  editMasterTool,
  deleteMasterTool,
} = require("../../controllers/masterTool/mastertool.controller");

var router = require("express").Router();

router.get("/get", getMasterTool);
router.post("/add", addMasterTool);
router.put("/edit", editMasterTool);
router.delete("/delete/:id", deleteMasterTool);

module.exports = router;
