///
///
///
///
/// [toValue] we use ot to convert the list items to string with , betwen
/// each item of list to use it in where statement of sqlite
/// when call IN( [values] );[values] is the string value that [toValues]
/// return it
///
///
String toValues<T>(List<T> items) {
  String values = "";
  for (int index = 0; index < items.length; index++) {
    T i = items[index];
    values += "$i";
    if ((index + 1) != items.length) values += ",";
  }
  return values;
}
