const {
  getMachines,
  addMachine,
  editMachines,
  deleteMachine,
  getMachinesOptions,
} = require("../../controllers/machines/machines.controllers");

const router = require("express").Router();

router.get("/get", getMachines);
router.post("/add", addMachine);
router.put("/edit/:id", editMachines);
router.put("/delete/:id", deleteMachine);
router.get("/options", getMachinesOptions);

module.exports = router;
