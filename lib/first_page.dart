import 'package:flutter/material.dart';
import 'package:flutter_arch/provider/repos.dart';
import 'package:flutter_arch/second_page.dart';
import 'package:provider/provider.dart';

import 'widget/list_item.dart';
import 'widget/loading.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).padding.top;
    print(appBarHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<ReposProvider>(
        builder: (context, repos, child) {
          if (repos.isLoading)
            return LoadingView();
          else
            return RefreshIndicator(
              onRefresh: repos.handleRefresh,
              child: ListView.separated(
                itemCount: repos.repos.length,
                itemBuilder: (context, index) {
                  return RepoListItem(repos.repos[index], index);
                },
                separatorBuilder: (context, index) => Divider(
                  height: 0.5,
                ),
              ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
      ),
    );
  }
}
