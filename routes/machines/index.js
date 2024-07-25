const {
    getMachines,
} = require("../../controllers/machines/machines.controllers");

const router = require("express").Router();

router.get("/get", getMachines);

module.exports = router;