import 'package:flutter/material.dart';

enum TabItem { red, green, blue }

Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};

class BottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  const BottomNavigation({this.currentTab, this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        buildItem(TabItem.red),
        buildItem(TabItem.green),
        buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }

  BottomNavigationBarItem buildItem(TabItem tabItem) {
    String text = tabName[tabItem];
    IconData icon = Icons.layers;
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _colorTabMatching(tabItem)),
      title: Text(
        text,
        style: TextStyle(color: _colorTabMatching(tabItem)),
      ),
    );
  }

  Color _colorTabMatching(TabItem tabItem) {
    return currentTab == tabItem ? activeTabColor[tabItem] : Colors.grey;
  }
}
