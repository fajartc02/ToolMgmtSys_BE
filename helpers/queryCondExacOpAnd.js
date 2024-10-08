function queryCondExacOpAnd(objs, dateBetweenCol = null) {
    let dateFilter = "";
    let containerQueryCond = [];
    if (dateBetweenCol) {
        dateFilter = `${dateBetweenCol} BETWEEN '${objs.start_date}' AND '${objs.end_date}'`;
        containerQueryCond.push(dateFilter);
    }
    console.log("containerQueryCond");
    console.log(containerQueryCond);
    delete objs.start_date;
    delete objs.end_date;
    for (const key in objs) {
        const element = objs[key];

        if (
            key !== "limit" &&
            key !== "currentPage" &&
            objs[key] != -1 &&
            objs[key] != "null" &&
            objs[key] != "" &&
            objs[key] != "-1/" &&
            objs[key] != null &&
            objs[key]
        ) {
            containerQueryCond.push(`${key} = '${`${element}`.replace("/", "")}'`);
    }
  }
  return containerQueryCond.length > 0
    ? " AND " + containerQueryCond.join(" AND ")
    : "";
}

module.exports = queryCondExacOpAnd;