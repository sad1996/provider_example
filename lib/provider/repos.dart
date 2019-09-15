import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_arch/model/repo.dart';
import 'package:flutter_arch/provider/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ReposProvider with ChangeNotifier {
  bool isLoading = true;
  List<Repo> repos = new List();
  Completer completer;
  BuildContext context;
  ConnectivityProvider connectivityProvider;

  ReposProvider(BuildContext context) {
    this.context = context;
    connectivityProvider;
    getRepositories();
  }

  init(){

  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  removeLoading() {
    isLoading = false;
    notifyListeners();
  }

  getRepositories() async {
    setLoading();
    await http
        .get('https://github-trending-api.now.sh/repositories')
        .then((responseData) {
      if (responseData != null) {
        List<dynamic> response = json.decode(responseData.body);
        repos = response.map<Repo>((json) => Repo.fromJson(json)).toList();
        if (completer != null) {
          completer.complete(null);
        }
        removeLoading();
        notifyListeners();
      }
    });
  }

  Future<Null> handleRefresh() async {
    completer = new Completer<Null>();
    await getRepositories();
    return completer.future.then((_) {});
  }
}
