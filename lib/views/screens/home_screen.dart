import 'package:flutter/material.dart';

import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedIndex,
          height: 50.0,
          items: <Widget>[
            LineIcon(LineIcons.home, size: 26, color: navbariconbg),
            const Icon(Icons.star_border_outlined,
                size: 26, color: navbariconbg),
            LineIcon(LineIcons.heading, size: 26, color: navbariconbg),
            LineIcon(LineIcons.barChartAlt, size: 26, color: navbariconbg),
            LineIcon(LineIcons.projectDiagram, size: 26, color: navbariconbg),
            LineIcon(LineIcons.userAlt, size: 26, color: navbariconbg),
          ],
          color: navbarbg,
          buttonBackgroundColor: selectednavbar,
          backgroundColor: selectednavbar,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: pages[_selectedIndex]);
  }
}
