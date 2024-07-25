const envFilePath =
  process.env.NODE_ENV?.trim() == "prod"
    ? "./prod.env"
    : process.env.NODE_ENV?.trim() == "dev"
    ? "./dev.env"
    : "./local.env";
require("dotenv").config({ path: envFilePath });
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var cors = require("cors");

var indexRouter = require("./routes/index");

var app = express();

const { database } = require("./config/database");

database.connect();
console.log("DB Connecttion:");
console.log({
  env: process.env.NODE_ENV?.trim(),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  host: process.env.DB_HOST,
  ssl: false,
});

app.use(logger("dev"));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.use("/", indexRouter);

module.exports = app;
