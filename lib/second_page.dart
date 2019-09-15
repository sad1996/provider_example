import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch/provider/connectivity.dart';
import 'package:provider/provider.dart';

import 'widget/no_connection.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  _SecondPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Consumer<ConnectivityProvider>(
            builder: (context, connectivity, child) {
          return Text(connectivity.connectivityResult == null
              ? 'Loading...'
              : connectivity.connectivityResult.toString());
        }),
      ),
    );
  }
}
