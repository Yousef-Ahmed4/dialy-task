validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return "it can't be empty";
  }
  if (val.length > max) {
    return "it can't be more than $max";
  }
  if (val.length < min) {
    return "it can't be less than $min";
  }
}
