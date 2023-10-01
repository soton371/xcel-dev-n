int textTrimLength(String msg) {
  if (msg.length > 80) {
    return 80;
  } else {
    return 40;
  }
}
