import 'dart:async';
import 'dart:convert';

import 'package:async_resource/async_resource.dart';
import 'package:async_resource/file_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_arch/model/employee.dart';
import 'package:flutter_arch/model/repo.dart';
import 'package:flutter_arch/provider/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EmployeesProvider with ChangeNotifier {
  bool isLoading = true;
  bool isLoadingMore = false;
  List<Employee> employees = new List();
  BuildContext context;
  bool hasDataAndNotExpired;
  int limit = 15;
  int page = 1;
  bool canLoadMore = true;

  EmployeesProvider(BuildContext context) {
    this.context = context;
    getEmployees(isFirstPage: true);
  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingMore() {
    isLoadingMore = true;
    notifyListeners();
  }

  removeLoading() {
    isLoading = false;
    notifyListeners();
  }

  removeLoadingMore() {
    isLoadingMore = false;
    notifyListeners();
  }

  incrementPage() {
    page++;
    notifyListeners();
  }

  setFirstPage() {
    page = 1;
    employees.clear();
    canLoadMore = true;
    notifyListeners();
  }

  getEmployees({bool isFirstPage}) async {
    if (isFirstPage != null && isFirstPage) {
      setFirstPage();
      setLoading();
    } else {
      setLoadingMore();
    }
    final path = (await getApplicationDocumentsDirectory()).path;
    print(path);
    String url =
        'https://webapp.syndicatebank.in/api/paginate.php?page=$page&limit=$limit';
    print(url);
    await http.get(url).then((responseData) {
      if (responseData != null) {
        List<dynamic> newList = json.decode(responseData.body)['data'];
        employees.addAll(
            newList.map<Employee>((json) => Employee.fromJson(json)).toList());
        if (newList.length != limit) {
          canLoadMore = false;
        }
        incrementPage();

        removeLoading();
        removeLoadingMore();
        notifyListeners();
      }
    });
  }

  Future<Null> handleRefresh() async {
    await getEmployees(isFirstPage: true);
  }
}
