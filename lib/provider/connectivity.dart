import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_arch/provider/repos.dart';
import 'package:provider/provider.dart';

class ConnectivityProvider with ChangeNotifier {
  StreamController<ConnectivityResult> _connectivityController =
      new StreamController<ConnectivityResult>.broadcast();
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool hasConnection;
  bool reloadRepos = false;

  ConnectivityProvider() {
    Connectivity().checkConnectivity().then((result) {
      connectivityResult = result;
      hasConnection = connectivityResult != ConnectivityResult.none;
      printStatus();
      notifyListeners();
    });
    addingStream();
    listeningToStream();
  }

  addingStream() {
    _connectivityController.addStream(Connectivity().onConnectivityChanged);
    notifyListeners();
  }

  listeningToStream() {
    _connectivityController.stream.listen((newResult) {
      connectivityResult = newResult;
      hasConnection = connectivityResult != ConnectivityResult.none;
      printStatus();

//      if (reloadRepos) {
//        Consumer<ReposProvider>(builder: (context, repos, _) {
//          if (hasConnection) {
//            reloadRepos = false;
//            repos.getRepositories();
//            notifyListeners();
//          }
//          return SizedBox();
//        });
//      }

      notifyListeners();
    });
    notifyListeners();
  }

  printStatus() {
    if (connectivityResult == ConnectivityResult.mobile) {
      print('I am connected to a mobile network.');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a wifi network.');
    } else if (connectivityResult == ConnectivityResult.none) {
      print('I am not connected to any network.');
    }
  }
}
