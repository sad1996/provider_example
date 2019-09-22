import 'dart:async';
import 'dart:convert';

import 'package:async_resource/async_resource.dart';
import 'package:async_resource/file_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_arch/model/repo.dart';
import 'package:flutter_arch/provider/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ReposProvider with ChangeNotifier {
  bool isLoading = true;
  HttpNetworkResource<List<Repo>> repoCall;
  List<Repo> repos = new List();
  Completer completer;
  BuildContext context;
  ConnectivityProvider connectivityProvider;
  bool hasDataAndNotExpired;

  ReposProvider(BuildContext context) {
    this.context = context;
    getRepositories();
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
    final path = (await getApplicationDocumentsDirectory()).path;
    print(path);
    repoCall = HttpNetworkResource<List<Repo>>(
      url: 'https://github-trending-api.now.sh/repositories',
      parser: (contents) => Repo.fromJsonArray(contents),
      cache: FileResource(File('$path/repos.json')),
      maxAge: Duration(minutes: 5),
      strategy: CacheStrategy.cacheFirst,
    );
    fetchRepos();
  }

  Future<Null> handleRefresh() async {
    completer = new Completer<Null>();
    await fetchRepos(forceReload: true);
    return completer.future.then((_) {});
  }

  Future fetchRepos({bool forceReload}) async {
    await repoCall
        .get(forceReload: forceReload != null ? forceReload : false)
        .then((list) async {
      repos = list;
      if (completer != null) {
        completer.complete(null);
      }
      notifyListeners();
    });
    removeLoading();
  }
}
