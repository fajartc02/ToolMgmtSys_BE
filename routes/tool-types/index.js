const router = require("express").Router();

const {
    getToolStandard,
} = require("../../controllers/tool-types/tool_type_std.controllers");

const {
    getToolTypes,
} = require("../../controllers/tool-types/tool_types.controllers");

router.get("/get", getToolTypes);
router.get("/get-standard", getToolStandard);

module.exports = router;