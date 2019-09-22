import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arch/provider/connectivity.dart';
import 'package:flutter_arch/provider/emloyees.dart';
import 'package:flutter_arch/provider/repos.dart';
import 'package:flutter_arch/widget/no_connection.dart';
import 'package:provider/provider.dart';
import 'first_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectivityProvider>(
            builder: (_) => ConnectivityProvider()),
        ChangeNotifierProvider<ReposProvider>(
            builder: (_) => ReposProvider(context)),
        ChangeNotifierProvider<EmployeesProvider>(
            builder: (_) => EmployeesProvider(context)),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            MaterialApp(
              title: 'Flutter Connectivity',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: FirstPage(title: 'Connectivity'),
            ),
//            Consumer<ConnectivityProvider>(
//                builder: (context, connectivity, child) {
//              return connectivity.connectivityResult == null ||
//                      connectivity.connectivityResult == ConnectivityResult.none
//                  ? NoConnection()
//                  : SizedBox();
//            })
          ],
        ),
      ),
    );
  }
}
