// import 'package:flappy_search_bar/flappy_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:practice_app/main.dart';
// import 'package:practice_app/profile.dart';

// class Contacts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contacts"),
//       ),
//         body: new Material(
//           child: new Column(
//           //  mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               new Expanded(
//                 flex: 0,
//                 child: Container(
//                   height: 90,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: SearchBar<Post>(
//                     onSearch: search,
//                     onItemFound: (Post post, int index) {
//                       return ListTile(
//                       title: Text(post.title),
//                       subtitle: Text(post.description)
//                        );
//                     },
//                   )
//                 )
//               ),
//               new Expanded(
//                 flex: 2,
//                 child: ContactList(),
//               ),
//              ]
//             )
//           ),
//         drawer: MyDrawer(),
//     );
//       // body: new Container(
//       //   height: 100,
//       //   child: new Column(
//       //     children: <Widget>[
//       //       ContactList(),
//       //       SafeArea(
//       //         child: Padding(
//       //           padding: const EdgeInsets.symmetric(horizontal: 20),
//       //             child: SearchBar(),
//       //           ),
//       //         )
//       //       ],
//       //     )
//       // ),
//         // drawer: MyDrawer(),
//     // );
//   //      if I want to use .builder, take out padding and separatorBuilder
//   }
// }

// class ContactList extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.all(2),
//       itemCount: 10,
//       itemBuilder: (BuildContext context, int index) {
//         return ContactCard();
//       },
//       separatorBuilder: (BuildContext contect, int index) => const Divider()
//     );
//   }

// }

// class Post {
//   final String title;
//   final String description;

//   Post(this.title, this.description);
// }

// Future<List<Post>> search(String search) async {
//   await Future.delayed(Duration(seconds: 2));
//   return List.generate(search.length, (int index) {
//     return Post(
//       "Title : $search $index",
//       "Description :$search $index",
//     );
//   });
// }