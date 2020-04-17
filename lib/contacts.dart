import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/businessCard.dart';
import 'package:practice_app/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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
                delegate: CustomSearchDelegate(ContactList('',''), '0')
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
                child: ContactList('0',''),
              ),
             ]
            )
          ),
        drawer: MyDrawer(),
    );
  }


}

class ContactList extends StatelessWidget{
  final String personal;
  final String query;
  ContactList(this.personal, this.query);
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BCard>>(
      future: getInfo(personal, query),
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
  }
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
  final ContactList contacts;
  final String personal;
  CustomSearchDelegate(this.contacts, this.personal);

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
                child: ContactList(personal, query),
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
    return ContactList(personal, ''
      // stream: contacts,
      // builder: (context, AsyncSnapshot<ContactList> snapshot),
    );
  }

}

  Future<List<BCard>> getInfo(personal, [String searchQuery]) async {
    final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
    final Database myDB = await database;
    final allRows = await myDB.rawQuery('SELECT * FROM business_card WHERE (personal = $personal) AND (f_name LIKE "%$searchQuery%" OR l_name LIKE "%$searchQuery%" OR mobile_number LIKE "%$searchQuery%"  OR email_addr LIKE "%$searchQuery%" OR street_addr LIKE "%$searchQuery%" OR notes LIKE "%$searchQuery%" OR title LIKE "%$searchQuery%" OR company LIKE "%$searchQuery%")');
    return List.generate(allRows.length, (i) {
      BCard a = new BCard(allRows[i]['card_id'], allRows[i]['f_name'], allRows[i]['l_name'],
        allRows[i]['mobile_number'],
        allRows[i]['email_addr'], allRows[i]['street_addr'],
        allRows[i]['website'], allRows[i]['linked_in'], 
        allRows[i]['personal'], allRows[i]['notes'],
        allRows[i]['title'], allRows[i]['company']);
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