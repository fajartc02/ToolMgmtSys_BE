// getGraphRegrdindingCount

const {
    getGraphRegrdindingCount,
} = require("../../controllers/graph/graph.controllers");

const router = require("express").Router();

router.get("/get", getGraphRegrdindingCount);

module.exports = router;