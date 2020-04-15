// import 'dart:collection';

// import 'package:flappy_search_bar/flappy_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:practice_app/businessCard.dart';
// import 'package:practice_app/main.dart';
// import 'package:practice_app/profile.dart';
// import 'package:sqflite/sqlite_api.dart';
// import 'package:practice_app/dogs.dart';

// class Contacts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contacts"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search), 
//             onPressed: () {
//               showSearch(
//                 context: context, 
//                 delegate: CustomSearchDelegate(ContactList())
//               );
//             },
//           ),
//         ],
//       ),
//         body: new Material(
//           child: new Column(
//             children: <Widget>[
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
  
//   final myDB = BusinessCard.instance;

//   //final contactsFromDB = query;
  
//   @override
//   Widget build(BuildContext context) {
//     var futureBuilder = new FutureBuilder (
//       future: BusinessCard(),
//       )
    
//    // return create listview

//     return ListView.separated(
//       padding: const EdgeInsets.all(2),
//       itemCount: 10,
//       itemBuilder: (BuildContext context, int index) {
//         return ContactCard();
//       },
//       separatorBuilder: (BuildContext contect, int index) => const Divider()
//     );
//   }
//   Future<int> _countRows() async {
//     // Assuming that the number of rows is the id for the last row.
//     return await myDB.queryRowCount();
//   }

//   // Future<List<BusinessCard>> getCardInfo() async {
//   //   final List<Map<String, dynamic>> maps = await myDB.queryAllRows();
//   //   return List.generate(maps.length, (i) {
//   //       return BusinessCard();
//   //     }
//   //   );
//   // }


//   Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
//     List<String> values = snapshot.data;
//     return new ListView.builder(
//         itemCount: values.length,
//         itemBuilder: (BuildContext context, int index) {
//           return new Column(
//             children: <Widget>[
//               new ListTile(
//                 title: new Text(values[index]),
//               ),
//               new Divider(height: 2.0,),
//             ],
//           );
//         },
//     );
//   }
// }

// class CustomSearchDelegate extends SearchDelegate {
//   // final UnmodifiableListView<ContactList> contacts;
//   final ContactList contacts;
//   CustomSearchDelegate(this.contacts);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   // button to close
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.length < 3) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: Text(
//               "Search term must be longer than two letters.",
//             ),
//           )
//         ],
//       );
//     }

    
//     //Add the search term to the searchBloc. 
//     //The Bloc will then handle the searching and add the results to the searchResults stream.
//     //This is the equivalent of submitting the search term to whatever search service you are using
//     // InheritedBlocs.of(context)
//     //     .searchBloc
//     //     .searchTerm
//     //     .add(query);

//     return Column(
//       children: <Widget>[
//         //Build the results based on the searchResults stream in the searchBloc
//         // StreamBuilder(
//         //   stream: InheritedBlocs.of(context).searchBloc.searchResults,
//         //   builder: (context, AsyncSnapshot<List<Result>> snapshot) {
//         //     if (!snapshot.hasData) {
//         //       return Column(
//         //         crossAxisAlignment: CrossAxisAlignment.center,
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: <Widget>[
//         //           Center(child: CircularProgressIndicator()),
//         //         ],
//         //       );
//         //     } else if (snapshot.data.length == 0) {
//         //       return Column(
//         //         children: <Widget>[
//         //           Text(
//         //             "No Results Found.",
//         //           ),
//         //         ],
//         //       );
//         //     } else {
//         //       var results = snapshot.data;
//         //       return ListView.builder(
//         //         itemCount: results.length,
//         //         itemBuilder: (context, index) {
//         //           var result = results[index];
//         //           return ListTile(
//         //             title: Text(result.title),
//         //           );
//         //         },
//         //       );
//         //     }
//         //   },
//         // ),
//       ],
//     );
    
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // This method is called everytime the search term changes. 
//     // If you want to add search suggestions as the user enters their search term, this is the place to do that.
//     return ContactList(
//       // stream: contacts,
//       // builder: (context, AsyncSnapshot<ContactList> snapshot),
//     );
//   }

// }