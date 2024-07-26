const { getUsers } = require("../../controllers/users/users.controllers");

const router = require("express").Router();

router.get("/get", getUsers);

module.exports = router;