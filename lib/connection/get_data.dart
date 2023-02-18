import 'package:student_attendance/connection/crud.dart';
import 'package:student_attendance/main.dart';
import '../constant/linkapi.dart';

getData(String url, String id) async {
  var responce = await Crud().postRequest(
    url,
    {
      "id": id,
    },
  );
  return responce;
}

getStudentSchdule() async {
  var responce = await Crud().postRequest(
    linkStudentSchedule,
    {
      "id": sharedPref.getString("id").toString(),
    },
  );
  return responce;
}
