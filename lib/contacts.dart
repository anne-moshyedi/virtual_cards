import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/businessCard.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/notes.dart';
import 'package:practice_app/profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:practice_app/dogs.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(ContactList(''))
              );
            },
          ),
        ],
      ),
        body: new Material(
          child: new Column(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: ContactList(''),
              ),
             ]
            )
          ),
        drawer: MyDrawer(),
    );
  }


}

class ContactList extends StatelessWidget{
  
  static final myDB = BusinessCard.instance;
  final String query;
  ContactList(this.query);

  //Future<Map<String, dynamic>> maps = myDB.queryAllRows();
  
  @override
  Widget build(BuildContext context) {
    //String searchQuery = ;
        return FutureBuilder<List<BCard>>(
          future: getInfo('0', query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("none");
          case ConnectionState.active:
          case ConnectionState.waiting:
            //return Text("active and maybe waiting");
          case ConnectionState.done:
            return ListView.separated(
                padding: const EdgeInsets.all(2),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //height: 50,
                    child: Center(child: snapshot.data[index]),
                  );
                },
                separatorBuilder: (BuildContext contect, int index) => const Divider()
              );
          default:
            return Text("done");
        }
      }
    );
    
    // ListView.separated(
    //   padding: const EdgeInsets.all(2),
    //   itemCount: _countRows(),
    //   itemBuilder: (BuildContext context, int index) {
    //     return ContactCard(card_id: 'ok');
    //   },
    //   separatorBuilder: (BuildContext contect, int index) => const Divider()
    // );
  }
  // Future<int> _countRows() async {
  //   // Assuming that the number of rows is the id for the last row.
  //   return await myDB.queryRowCount();
  // }

  // Future<List<BusinessCard>> getCardInfo() async {
  //   final List<Map<String, dynamic>> maps = await myDB.queryAllRows();
  //   return List.generate(maps.length, (i) {
  //       return BusinessCard();
  //     }
  //   );
  // }


  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(values[index]),
              ),
              new Divider(height: 2.0,),
            ],
          );
        },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // final UnmodifiableListView<ContactList> contacts;
  final ContactList contacts;
  CustomSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // button to close
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    
    //Add the search term to the searchBloc. 
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    // InheritedBlocs.of(context)
    //     .searchBloc
    //     .searchTerm
    //     .add(query);
    return Column(
      children: <Widget>[
        new Expanded(
                flex: 2,
                child: ContactList(query),
              ),
        // Build the results based on the searchResults stream in the searchBloc
        // StreamBuilder(
        //   stream: InheritedBlocs.of(context).searchBloc.searchResults,
        //   builder: (context, AsyncSnapshot<List<Result>> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Center(child: CircularProgressIndicator()),
        //         ],
        //       );
        //     } else if (snapshot.data.length == 0) {
        //       return Column(
        //         children: <Widget>[
        //           Text(
        //             "No Results Found.",
        //           ),
        //         ],
        //       );
        //     } else {
        //       var results = snapshot.data;
        //       return ListView.builder(
        //         itemCount: results.length,
        //         itemBuilder: (context, index) {
        //           var result = results[index];
        //           return ListTile(
        //             title: Text(result.title),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
      ],
    );
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes. 
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return ContactList(''
      // stream: contacts,
      // builder: (context, AsyncSnapshot<ContactList> snapshot),
    );
  }

}

  Future<List<BCard>> getInfo(personal, [String searchQuery]) async {
    final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
    final Database myDB = await database;
    //final allRows = await myDB.query('business_card');
    //if (searchQuery == '')
      //final allRows = await myDB.rawQuery('SELECT * FROM business_card WHERE personal=$personal');
    
    final allRows = await myDB.rawQuery('SELECT * FROM business_card WHERE personal = $personal AND (f_name LIKE "%$searchQuery%" OR l_name LIKE "%$searchQuery%" OR mobile_number LIKE "%$searchQuery%"  OR email_addr LIKE "%$searchQuery%" OR street_addr LIKE "%$searchQuery%" OR notes LIKE "%$searchQuery%" OR title LIKE "%$searchQuery%" OR company LIKE "%$searchQuery%")');
    return List.generate(allRows.length, (i) {
      // my issue is that for some reason card_id and mobile_number is an int
      // var v = allRows[i]['mobile_number'];
      // print(v);
      // if (v is String ) print("String");
      BCard a = new BCard(allRows[i]['card_id'], allRows[i]['f_name'], allRows[i]['l_name'],
        allRows[i]['mobile_number'],
        allRows[i]['email_addr'], allRows[i]['street_addr'],
        allRows[i]['website'], allRows[i]['linked_in'], 
        allRows[i]['personal'], allRows[i]['notes'],
        allRows[i]['title'], allRows[i]['company']);
      //print(a.personal);
      return (a);
    });
  }


  // class InheritedBlocs extends InheritedWidget {
  // InheritedBlocs(
  //     {Key key,
  //     this.searchBloc,
  //     this.child})
  //     : super(key: key, child: child);

  // final Widget child;
  // final SearchBloc searchBloc;
  
  //   static InheritedBlocs of(BuildContext context) {
  //     return (context.inheritFromWidgetOfExactType(InheritedBlocs)
  //         as InheritedBlocs);
  //   }
  
  //   @override
  //   bool updateShouldNotify(InheritedBlocs oldWidget) {
  //     return true;
  //   }
  // }