// import 'package:flutter/material.dart';
// import 'package:student_attendance/app/componants/componants.dart';
// import 'package:student_attendance/app/componants/crud.dart';
// import 'package:student_attendance/app/componants/valid.dart';
// import 'package:student_attendance/constant/linkapi.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   Crud _crud = Crud();
//   bool isLoading = false;
//   GlobalKey<FormState> formstate = GlobalKey();
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();

//   signUp() async {
//     if (formstate.currentState!.validate()) {
//       isLoading = true;
//       setState(() {});
//       var responce = await _crud.postRequest(linkSignUp, {
//         "name": name.text,
//         "email": email.text,
//         "password": password.text,
//       });

//       isLoading = false;
//       setState(() {});

//       if (await responce['status'] == "success") {
//         Navigator.of(context)
//             .pushNamedAndRemoveUntil("login", (route) => false);
//       } else {
//         print('sign up fail');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading == true
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               padding: EdgeInsets.all(10),
//               child: ListView(
//                 children: [
//                   Form(
//                     key: formstate,
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           "assets/logo.png",
//                           width: 200,
//                           height: 200,
//                         ),
//                         CustTextForm(
//                           valid: (val) {
//                             return validInput(val!, 5, 20);
//                           },
//                           mycontroller: name,
//                           hint: 'user name',
//                         ),
//                         CustTextForm(
//                           valid: (val) {
//                             return validInput(val!, 10, 50);
//                           },
//                           mycontroller: email,
//                           hint: 'email',
//                         ),
//                         CustTextForm(
//                           valid: (val) {
//                             return validInput(val!, 8, 20);
//                           },
//                           mycontroller: password,
//                           hint: 'password',
//                         ),
//                         MaterialButton(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 70, vertical: 10),
//                           child: Text('sign up'),
//                           color: Colors.blue,
//                           textColor: Colors.white,
//                           onPressed: () async {
//                             await signUp();
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         InkWell(
//                           child: Text('log in'),
//                           onTap: () {
//                             Navigator.of(context).pushNamed('login');
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
