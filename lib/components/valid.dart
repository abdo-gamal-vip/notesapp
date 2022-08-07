import 'package:notesapp/constant/massages.dart';

validInput(
  String val,
  int min,
  int max,
) {
  if (val.isEmpty) {
    return massageInputEmpty;
  } else if (val.length < min) {
    return massageInputMin + min.toString();
  } else if (val.length > max) {
    return massageInputMax + max.toString();
  } else {
    return null;
  }
}

emailValid(
  String val,
  validInput,
) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val);
  if (emailValid == false) {
    return "الاميل فى حاجه غلط";
  }
}
