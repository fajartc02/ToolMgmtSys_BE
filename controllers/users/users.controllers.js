const { error, success } = require("../../helpers/response");
const { tb_m_users } = require("../../config/table");
const { queryGET } = require("../../helpers/query");
const getPaginatedData = require("../../functions/PAGINATION");

module.exports = {
    getUsers: async(req, res) => {
        try {
            const result = await queryGET(tb_m_users);
            success(res, "Success", result);
        } catch (err) {
            console.log(err);
            error(res, err);
        }
    },
};