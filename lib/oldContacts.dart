import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:practice_app/businessCard.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
        body: new Material(
          child: new Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 0,
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBar<Post>(
                    onSearch: search,
                    onItemFound: (Post post, int index) {
                      return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.description)
                       );
                    },
                  )
                )
              ),
              new Expanded(
                flex: 2,
                child: ContactList(),
              ),
             ]
            )
          ),
        drawer: MyDrawer(),
    );
      // body: new Container(
      //   height: 100,
      //   child: new Column(
      //     children: <Widget>[
      //       ContactList(),
      //       SafeArea(
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 20),
      //             child: SearchBar(),
      //           ),
      //         )
      //       ],
      //     )
      // ),
        // drawer: MyDrawer(),
    // );
  //      if I want to use .builder, take out padding and separatorBuilder
  }
}

class ContactList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ContactCard();
      },
      separatorBuilder: (BuildContext contect, int index) => const Divider()
    );
  }

}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description :$search $index",
    );
  });
}

  Future<List<BCard>> _getInfo() async {
    final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
    final Database myDB = await database;
    final allRows = await myDB.query('business_card');
    //print("printing all rows:");
    //print(allRows.length);
    return List.generate(allRows.length, (i) {
      // my issue is that for some reason card_id and mobile_number is an int
      // var v = allRows[i]['mobile_number'];
      // print(v);
      // if (v is String ) print("String");
      BCard a = new BCard(allRows[i]['card_id'], allRows[i]['f_name'], allRows[i]['l_name'],
        allRows[i]['mobile_number'],
        allRows[i]['email_addr'], allRows[i]['street_addr'],
        allRows[i]['website'], allRows[i]['linked_in'], 
        allRows[i]['personal'], allRows[i]['notes'], );
      //print(a.personal);
      return (a);
    });
  }