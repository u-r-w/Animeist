import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdemo/api.dart';
import 'package:flutterdemo/mainItem.dart';
import 'package:flutterdemo/model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<MainItem>> _fetchData() async{
    final request = await http.get(Api.topAnime);

    if (request.statusCode == 200){
      List response = json.decode(request.body)['top'];

      List<MainItem> data = [];

      for (var i = 0; i < response.length; i++){
        data.add(MainItem(
          model: Model(
            response[i]['main_id'],
            response[i]['rank'],
            response[i]['title'],
            response[i]['url'],
            response[i]['image_url'],
            response[i]['type'],
            response[i]['episodes'],
            response[i]['start_date'],
            response[i]['end_date'],
            response[i]['members'],
            response[i]['score'].round(),
          ),
        ));
      }return data;
    }else{
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime List"),
      ),body: FutureBuilder(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return loadingPage();
            case ConnectionState.waiting:
              return loadingPage();
            case ConnectionState.none:
              return errorPage(context, snapshot);
            case ConnectionState.done:
              if (snapshot.hasData) {
                return homePage(snapshot.data);
              } else if (snapshot.hasError) {
                return errorPage(context, snapshot);
              } else {
                return errorPage(context, snapshot);
              }
              break;
            default:
          }
        },
      ),
    );
  }
  
  Widget loadingPage() => Center(
    child: CircularProgressIndicator(backgroundColor: Colors.blue)
  );

  Widget errorPage(context, snapshot) => Center(
    child: Column(
      children: <Widget>[
        Text("Failed on fetching data"),
        RaisedButton(
          onPressed: (){
            setState(() {
              
            });
          },
          child: Text("Try again"),
        )
      ],
    ),
  );

  Widget homePage(List<MainItem> anime) => ListView.builder(
    itemCount: anime.length,
    itemBuilder: (context, index) => anime[index]
  ); 
}