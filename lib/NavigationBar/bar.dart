import 'package:flutter/material.dart';
import 'package:flutter_app/NavigationBar/messages.dart';
import 'package:flutter_app/NavigationBar/home.dart';
import 'package:flutter_app/NavigationBar/notifications.dart';
import 'package:flutter_app/NavigationBar/list.dart';
import 'package:flutter_app/Theme/app_padding.dart';

class Bar extends StatefulWidget {
  final String nome;
  const Bar({super.key, this.nome = ''});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: theme.secondaryHeaderColor,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.messenger_sharp),
              ),
              label: 'Messages',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.list),
              icon: Icon(Icons.list_outlined),
              label: 'List',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium, vertical: AppPadding.large),
          child: <Widget>[
            const Home(),
            const Notifications(),
            const Messages(),
            const ListProduct(),
          ][currentPageIndex],
        ));
  }
}
