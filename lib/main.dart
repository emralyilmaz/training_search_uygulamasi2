import 'package:flutter/material.dart';

String secilen;
void main() => runApp(MaterialApp(
      home: SearchApp(),
    ));

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şehirler"),
        backgroundColor: Color.fromRGBO(81, 51, 59, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchVerileri());
            },
          )
        ],
      ),
    );
  }
}

class SearchVerileri extends SearchDelegate<String> {
  final sehirler = [
    "Adana",
    "Ankara",
    "İstanbul",
    "Adıyaman",
    "İzmir",
    "Bursa",
    "Antalya",
    "Zonguldak"
  ];

  final sonsehirler = ["İstanbul", "Ankara", "İzmir", "Antalya"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      color: Color.fromRGBO(170, 138, 87, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              secilen,
              style: TextStyle(fontSize: 50),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final oneriListesi = query.isEmpty
        ? sonsehirler
        : sehirler.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
          secilen = oneriListesi[index];
        },
        leading: Icon(Icons.location_city),
        title: RichText(
            text: TextSpan(
                text: oneriListesi[index].substring(0, query.length),
                style: TextStyle(
                    color: Color.fromRGBO(81, 51, 59, 1),
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: oneriListesi[index].substring(query.length),
                  style: TextStyle(color: Color.fromRGBO(170, 138, 87, 1)))
            ])),
      ),
      itemCount: oneriListesi.length,
    );
  }
}
