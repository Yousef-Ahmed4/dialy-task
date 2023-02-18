// import 'package:flutter/material.dart';

// import 'package:student_attendance/app/componants/cardnote.dart';
// import 'package:student_attendance/app/componants/crud.dart';
// // import 'package:student_attendance/app/notes/edit.dart';
// import 'package:student_attendance/constant/linkapi.dart';
// import 'package:student_attendance/main.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with Crud {
//   getNotes() async {
//     var responce =
//         await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
//     return responce;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               sharedPref.clear();
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil("login", (route) => false);
//             },
//             icon: Icon(Icons.exit_to_app),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).pushNamed('addnote');
//           },
//           child: Icon(Icons.add)),
//       body: Container(
//         margin: EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             FutureBuilder(
//               future: getNotes(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator()
//                       //  Text('is loading...'),
//                       );
//                 }
//                 if (snapshot.hasData) {
//                   if (snapshot.data["status"] == 'fail')
//                     return Center(
//                         child: Text(
//                       'no data',
//                       style: TextStyle(fontSize: 23),
//                     ));
//                   return ListView.builder(
//                       itemCount: snapshot.data['data'].length,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, i) {
//                         return CardNotes(
//                           onDelete: () async {
//                             var response = await postRequest(linkDeleteNotes, {
//                               "id": snapshot.data['data'][i]['id'].toString(),
//                             });
//                             if (response["status"] == "success") {
//                               Navigator.of(context)
//                                   .pushReplacementNamed("home");
//                             }
//                           },
//                           content: '${snapshot.data['data'][i]['content']}',
//                           title: '${snapshot.data['data'][i]['title']}',
//                           ontap: () {
//                             // Navigator.of(context).push(
//                             //   MaterialPageRoute(
//                             //     builder: (context) => EditNotes(
//                             //       notes: snapshot.data['data'][i],
//                             //     ),
//                             //   ),
//                             // );
//                           },
//                         );
//                       });
//                 }

//                 return Center(child: Text('is loading...'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

































// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'dart:convert';

// List blockBustorDealList = [
//     {
//       'image':
//           'https://is.simplify.cool/component/admin/upload_img/demo/backend/files/thumbnail/NEC56049_thumbnail.webp?v=20220602014017',
//       'title': 'Trick R Treat Ultimate Sam',
//       'offer': 'RMB 54.90'
//     },
//     {
//       'image':
//           'https://is.simplify.cool/component/admin/upload_img/demo/backend/files/thumbnail/NEC61901_thumbnail.webp?v=20220602014017',
//       'title': 'Blockbustor Deals On TVs',
//       'offer': 'From ₹5,499'
//     },
//     {
//       'image':
//           'https://is.simplify.cool/component/admin/upload_img/demo/backend/files/thumbnail/NEC54206_thumbnail.webp?v=20220602014017',
//       'title': 'Asian, Kraasa & more',
//       'offer': 'Min. 55% Off'
//     },
//     {
//       'image':
//           'https://is.simplify.cool/component/admin/upload_img/demo/backend/files/thumbnail/NEC54226_thumbnail.webp?v=20220602014017',
//       'title': 'Puma, FILA & more',
//       'offer': 'Min. 60% Off'
//     }
//   ];

// class  extends StatefulWidget {
//   const ({ Key? key }) : super(key: key);

//   @override
//   State<> createState() => _State();
// }

// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }





//    Future<List<dynamic>> getJobsData() async {
//     String url = 'https://is.simplify.cool/flutter/products.php';
//     var response = await http.get(Uri.parse(url), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     });
//     return json.decode(response.body);
//   }


//  FutureBuilder<List<dynamic>>(
//     future: getJobsData(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             shrinkWrap: true,//add this line
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, index) {
//               var title = snapshot.data[index]['title'];
//               var image = snapshot.data[index]['image'];
//               var offer = snapshot.data[index]['offer'];

//               return Card(
//                 elevation: 5,
//                 shadowColor: Colors.grey,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                     20,
//                   ),
//                 ),
//                 margin: EdgeInsets.all(5),
//                 child: Container(
//                   height: 300,
//                   width: 200,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(
//                                 10,
//                               ),
//                               topRight: Radius.circular(
//                                 10,
//                               ),
//                             ),
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: NetworkImage(
//                                 image,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 2,
//                         color: Colors.black,
//                       ),
//                       Container(
//                         height: 80,
//                         padding: const EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20.0),
//                             bottomRight: Radius.circular(20.0),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               title,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               offer,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     },
//   ),