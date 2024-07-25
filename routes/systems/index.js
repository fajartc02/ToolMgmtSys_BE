const { getSystems } = require("../../controllers/systems/systems.controllers");

const router = require("express").Router();

router.get("/get", getSystems);

module.exports = router;