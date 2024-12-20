const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { tb_m_users_for_master_data } = require("../config/table"); // Model User dari database
const { queryGET, queryPOST, queryTransaction } = require("../helpers/query");
const GET_LAST_ID = require("../functions/GET_LAST_ID");
const moment = require("moment");

// Fungsi untuk login
module.exports = {
  login: async (req, res) => {
    try {
      const { username, password } = req.body;

      const user = await queryGET(
        tb_m_users_for_master_data,
        `WHERE username = '${username}'`
      );

      // Pastikan user ditemukan dan password ada di dalam data
      if (!user || !user.length) {
        console.log("User not found for username:", username);
        return res.status(400).json({ message: "Invalid credentials" });
      }

      // Ambil data user pertama jika query menghasilkan array
      const userData = user[0];

      // Cek apakah password yang dimasukkan sesuai dengan hash di database
      const isMatch = await bcrypt.compare(password, userData.password);
      console.log("Password match:", isMatch); // Menampilkan hasil perbandingan password

      if (!isMatch) {
        console.log("Incorrect password for username:", username);
        return res.status(400).json({ message: "Invalid credentials" });
      }

      // Membuat token JWT
      const token = jwt.sign(
        { userId: userData.id },
        process.env.JWT_SECRET_KEY,
        {
          expiresIn: "1h",
        }
      );

      console.log("Login successful for user:", username);

      // Mengirimkan token dan data user sebagai respons
      res.status(200).json({ token, user: userData });
    } catch (err) {
      console.error("Error during login:", err); // Menampilkan error yang terjadi
      res.status(500).json({ message: "Server error", error: err.message });
    }
  },
  register: async (req, res) => {
    try {
      await queryTransaction(async (db) => {
        // Cek apakah noreg sudah ada
        const noregCondition = `WHERE noreg = '${req.body.noreg}'`;

        console.log(noregCondition);

        let existingUser = await queryGET(
          tb_m_users_for_master_data,
          noregCondition
        );

        if (existingUser.length > 0) {
          // Jika noreg sudah ada, kembalikan respons error
          res.status(400).json({
            message: "Noreg already exists",
          });
        }
        // Jika ada file, tambahkan ke req.body
        if (req.file) {
          req.body.photo = `uploads/${req.file.filename}`; // Simpan path file atau sesuai kebutuhan
        }
        // Ambil ID terakhir dari Users
        let id = await GET_LAST_ID("id", tb_m_users_for_master_data);
        req.body.id = id;

        // Encrypt password
        req.body.password = await bcrypt.hash(req.body.password, 10);

        // Set additional fields
        req.body.created_at = moment().format("YYYY-MM-DD HH:mm:ss");

        // Insert data baru ke Users
        console.log(req.body);
        let responseInserted = await queryPOST(
          tb_m_users_for_master_data,
          req.body,
          db
        );

        return responseInserted;
      });

      res.status(201).json({
        message: "User registered successfully",
        data: { code: 1, message: "INSERTED" },
      });
    } catch (err) {
      console.error(err);
      res.status(400).json({
        message: err.message || "Registrasi gagal.",
        data: { code: 0, message: "FAILED" },
      });
    }
  },
};
