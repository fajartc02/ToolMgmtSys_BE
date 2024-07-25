function GENERATE_TOOL_QR(tool_qr) {
    return "A" + (+tool_qr.slice(1) + 1);
}

module.exports = GENERATE_TOOL_QR;