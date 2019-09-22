import 'package:flutter/material.dart';
import 'package:flutter_arch/widget/loading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'model/employee.dart';
import 'provider/emloyees.dart';
import 'widget/lazy_load_widget.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  _SecondPageState();

  int pageThreshold = 5;

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeesProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
          actions: <Widget>[
            if (!provider.isLoading)
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: provider.handleRefresh,
              )
          ],
        ),
        body: provider.isLoading
            ? LoadingView()
            : RefreshIndicator(
                onRefresh: provider.handleRefresh,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: LazyLoadScrollView(
                        child: ListView.separated(
                          itemCount: provider.employees.length,
                          itemBuilder: (context, index) {
                            Employee employee = provider.employees[index];
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child: Container(
                                child: ListTile(
                                  isThreeLine: true,
                                  onTap: () {},
                                  leading: Hero(
                                    tag: employee.customerId,
                                    child: Material(
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.redAccent)),
                                      child: ClipOval(
                                        child: Icon(Icons.person, size: 30),
                                      ),
                                    ),
                                  ),
                                  title: Text(employee.firstName +
                                      " " +
                                      employee.lastName),
                                  subtitle: Text(employee.email.toString() +
                                      '\n' +
                                      employee.phone.toString()),
                                ),
                                color: index.isEven
                                    ? Colors.grey.shade100
                                    : Colors.white,
                              ),
                              actions: <Widget>[
                                IconSlideAction(
                                  caption: 'Share',
                                  color: Colors.indigo,
                                  icon: Icons.share,
                                  onTap: () {},
                                ),
                              ],
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () async {},
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 0.5,
                            );
                          },
                        ),
                        isLoading: provider.isLoadingMore,
                        onEndOfPage: () {
                          if (provider.canLoadMore) {
                            print('Called LoadMore');
                            provider.getEmployees();
                          } else {
                            print('Reached the end');
                          }
                        },
                        scrollOffset: 500,
                      ),
                    ),
                    provider.isLoadingMore
                        ? Container(
                            height: 70,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
        floatingActionButton: provider.isLoading
            ? SizedBox()
            : FloatingActionButton.extended(
                onPressed: null, label: Text('Page: ${provider.page - 1}')),
      );
    });
  }
}
