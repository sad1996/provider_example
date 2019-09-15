import 'package:flutter/material.dart';
import 'package:flutter_arch/model/repo.dart';

class RepoListItem extends StatelessWidget {
  RepoListItem(this.repo, this.i);

  final Repo repo;
  final int i;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    final TextTheme textTheme = theme.textTheme;

    return ListTile(
      leading: CircleAvatar(
        minRadius: 20,
        maxRadius: 20,
        backgroundColor: Colors.grey.shade50,
        backgroundImage: NetworkImage(
            checkIfNull(repo.avatar)),
      ),
      title: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              checkIfNull(repo.author),
              style: textTheme.caption,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              checkIfNull(repo.name),
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: textTheme.title.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  checkIfNull(data) {
    return data != null ? data : '';
  }
}
