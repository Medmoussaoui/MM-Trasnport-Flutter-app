String? requiredFormValidation(String? input) {
  if (input!.isEmpty) {
    return "هذا الحقل اجباري";
  }
  return null;
}
