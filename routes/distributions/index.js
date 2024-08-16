const {
  getDistributions,
  addDistribution,
  editDistribution,
  deleteDistribution,
} = require("../../controllers/distributions/distributions.controllers");

const router = require("express").Router();

router.get("/get", getDistributions);
router.post("/add", addDistribution);
router.put("/edit/:id", editDistribution);
router.put("/delete/:id", deleteDistribution);

module.exports = router;
