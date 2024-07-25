const {
    getDistributions,
} = require("../../controllers/distributions/distributions.controllers");

const router = require("express").Router();

router.get("/get", getDistributions);

module.exports = router;