const {
  getUsers,
  getUserOptions,
  addUser,
  getUserMeta,
  editUser,
  deleteUser,
} = require("../../controllers/users/users.controllers");

const router = require("express").Router();

router.get("/get", getUsers);
router.get("/options/:filters", getUserOptions);
router.post("/add", addUser);
router.get("/meta", getUserMeta);
router.put("/edit/:id", editUser);
router.put("/delete/:id", deleteUser);

module.exports = router;
