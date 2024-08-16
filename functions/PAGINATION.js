const { queryCustom } = require("../helpers/query");
const moment = require("moment");

async function getPaginatedData(
  tableName,
  currentPage = 1,
  itemsPerPage = 1000,
  whereCond = null,
  columnOrderDesc = null,
  joinCondition = null,
  joinColumns = null, // Tambahkan parameter untuk kolom yang di-join
  hasDeletedDt = false // Default ke false jika tabel tidak memiliki deleted_dt
) {
  try {
    const offset = (currentPage - 1) * itemsPerPage;

    // Tentukan kondisi deleted_dt jika tabel memiliki kolom ini
    const deletedDtCondition = hasDeletedDt
      ? `${tableName}.deleted_dt IS NULL`
      : "1=1";

    // Query untuk menghitung total data
    const totalCountResult = await queryCustom(
      `SELECT COUNT(*) FROM ${tableName}
       ${joinCondition ? joinCondition : ""}
       WHERE ${deletedDtCondition} ${whereCond ? `AND ${whereCond}` : ""}`
    );
    const totalCount = parseInt(totalCountResult.rows[0].count, 10);

    // Sesuaikan offset jika totalCount lebih kecil dari offset
    const adjustedOffset = totalCount < offset ? 0 : offset;

    // Tentukan kolom yang akan di-join jika ada
    const columns = joinColumns
      ? `${tableName}.*, ${joinColumns}`
      : `${tableName}.*`;

    // Query untuk mengambil data yang dipaginasi
    const dataResult = await queryCustom(
      `
        SELECT ROW_NUMBER() OVER (
          ${columnOrderDesc ? `ORDER BY ${columnOrderDesc} DESC` : ""}
        ) as no, 
        ${columns}
        FROM ${tableName}
        ${joinCondition ? joinCondition : ""}
        WHERE ${deletedDtCondition} ${whereCond ? `AND ${whereCond}` : ""}
        ${columnOrderDesc ? `ORDER BY ${columnOrderDesc} DESC` : ""}
        ${itemsPerPage ? `LIMIT ${itemsPerPage} OFFSET ${adjustedOffset}` : ""}`
    );

    // Format tanggal jika kolom created_dt ada
    dataResult.rows.forEach((row) => {
      if (row.created_dt) {
        row.created_dt = moment(row.created_dt).format("DD-MM-YYYY");
      }
    });

    return {
      data: dataResult.rows,
      meta: {
        totalData: totalCount,
        currentPage: Number(currentPage),
        itemsPerPage: Number(itemsPerPage),
        totalPages: Math.ceil(totalCount / itemsPerPage),
      },
    };
  } catch (err) {
    console.error("Error fetching paginated data:", err);
    throw err;
  }
}

module.exports = getPaginatedData;
