import 'package:flutter/material.dart';

import 'package:magiquery/pages/card_detail.dart';
import 'package:magiquery/pages/nav_tab_bar.dart';
import 'package:magiquery/pages/set_detail.dart';
import 'package:magiquery/pages/set_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magiquery',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        hintColor: Colors.deepOrange,
        accentColor: Colors.green,
        highlightColor: Colors.blueAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => NavTabBar(),
        'card-detail': (BuildContext context) => CardDetail(),
        'set-list': (BuildContext context) => SetListPage(),
        'set-detail': (BuildContext context) => SetDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
