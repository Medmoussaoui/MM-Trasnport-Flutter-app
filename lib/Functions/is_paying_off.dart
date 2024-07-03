bool isPayingOffServiceType(String value) {
  value = value.trim().toLowerCase();
  if (value == "paye") return true;
  if (value == "paid") return true;
  if (value == "خالص") return true;
  if (value == "دفع") return true;
  if (value == "شديت") return true;
  if (value == "شدية") return true;
  if (value == "خديت") return true;
  return false;
}
