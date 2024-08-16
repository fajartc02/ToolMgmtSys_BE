const {
  getSystems,
  addSystem,
  editSystem,
  deleteSystem,
} = require("../../controllers/systems/systems.controllers");

const router = require("express").Router();

router.get("/get", getSystems);
router.post("/add", addSystem);
router.put("/edit/:id", editSystem);
router.put("/delete/:id", deleteSystem);

module.exports = router;
