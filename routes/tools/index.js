const {
  getDrawings,
  addDrawing,
  editDrawing,
  searchDrawing,
} = require("../../controllers/tools/drawing.controller");
const {
  getMeasurements,
  deleteMeasureament,
  addMeasurements,
  deleteDrawing,
} = require("../../controllers/tools/measurements.controller");
const {
  submitToolHistory,
  getToolHistories,
} = require("../../controllers/tools/tool_histories.controllers");
const {
  getTools,
  generateToolQR,
  addTool,
  updatePos,
} = require("../../controllers/tools/tools.controllers");
const {
  getToolByQR,
} = require("../../controllers/tools/tools_positions.controllers");

const router = require("express").Router();

router.get("/get", getTools);
router.get("/details", getToolByQR);
router.get("/generateQR", generateToolQR);

router.post("/add", addTool);
router.get("/history", getToolHistories);
router.post("/history", submitToolHistory);

router.put("/position", updatePos);
router.get("/drawing", getDrawings);
router.post("/drawing/add", addDrawing);
router.use("/drawing/edit/:id", editDrawing);
router.get("/measurements", getMeasurements);
router.put("/measurements/delete/:id", deleteMeasureament);
router.put("/measurements/add", addMeasurements);
router.put("/delete/:id", deleteDrawing);
router.get("/search", searchDrawing);

module.exports = router;
