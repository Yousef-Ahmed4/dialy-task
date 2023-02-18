import 'crud.dart';
import '../constant/linkapi.dart';
import '../main.dart';

Future<String> getDoctorData() async {
  var responce = await Crud().postRequest(
    linkDoctorLogin,
    {
      "id": sharedPref.getString("id").toString(),
      "password": sharedPref.getString("password").toString(),
    },
  );
  sharedPref.setString(
      "doctor_name", responce["data"]["doctor_name"].toString());
  sharedPref.setString("phone", responce["data"]["phone"].toString());
  sharedPref.setString("email", responce["data"]["email"].toString());
  return responce.toString();
}

Future<String> getStudentData() async {
  var responce = await Crud().postRequest(
    linkStudentLogin,
    {
      "id": sharedPref.getString("id").toString(),
      "password": sharedPref.getString("password").toString(),
    },
  );
  sharedPref.setString(
      "student_name", responce["data"]["student_name"].toString());
  sharedPref.setString("phone", responce["data"]["phone"].toString());
  sharedPref.setString("studentlevel", responce["data"]["level"].toString());
  sharedPref.setString("email", responce["data"]["email"].toString());
  return responce.toString();
}
