import 'package:bottom_navigation/bottom_navigation.dart';
import 'package:bottom_navigation/tab_navigator.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TabItem _currentTab = TabItem.red;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
  };

  Future<bool> onWillPop() async {
    final isFirstRouteInTab =
        !await _navigatorKeys[_currentTab].currentState.maybePop();
    if (isFirstRouteInTab) {
      if (_currentTab != TabItem.red) {
        _onSelectTab(TabItem.red);
        return false;
      }
    }
    return isFirstRouteInTab;
  }

  void _onSelectTab(TabItem tabItem) {
    if (_currentTab == tabItem) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            buildPage(TabItem.red),
            buildPage(TabItem.green),
            buildPage(TabItem.blue),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _onSelectTab,
        ),
      ),
    );
  }

  Widget buildPage(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
