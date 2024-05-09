import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appcolors.dart';
// import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/screens/admin/inoffice_screen.dart';
import 'package:hawk/screens/admin/profile_screen.dart';
import 'package:hawk/screens/admin/user_list_screen.dart';
import 'package:hawk/screens/admin/requests_screen.dart';
import 'package:hawk/widgets/gradientstack.dart';

class AdHomeScreen extends StatefulWidget {
  const AdHomeScreen({super.key});

  @override
  _AdHomeScreenState createState() => _AdHomeScreenState();
}

class _AdHomeScreenState extends State<AdHomeScreen> {
  int _currentScreenIndex = 1;

  // List of widgets to use as bodies of the navigation bar
  static final List<Widget> _screens = <Widget>[
    const RequestsScreen(),
    const UserListScreen(),
    const InOfficeScreen(),
    const AdProfileScreen(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentScreenIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 22,
          currentIndex: _currentScreenIndex,
          onTap: _onTapChangeScreen,
          selectedItemColor: Colors.white,
          backgroundColor: AppColors.darkBg,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: 'Requests',
              icon: Icon(EvaIcons.checkmarkSquare2),
            ),
            BottomNavigationBarItem(
              label: 'Records',
              icon: Icon(Icons.calendar_month),
            ),
            BottomNavigationBarItem(
              label: 'In Office',
              icon: Icon(EvaIcons.briefcaseOutline),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(EvaIcons.person),
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _upadateCurrentScreenIndex,
          itemCount: _screens.length,
          itemBuilder: (context, index) {
            return _getScreen(context, index);
          },
        ),
      ),
    );
  }

  int _getValidScreenIndex(int value) {
    return value < 0
        ? 0
        : value > _screens.length - 1
            ? _screens.length - 1
            : value;
  }

  void _upadateCurrentScreenIndex(int value) {
    int validIndex = _getValidScreenIndex(value);

    setState(() {
      _currentScreenIndex = validIndex;
    });
  }

  void _onTapChangeScreen(int value) {
    _upadateCurrentScreenIndex(value);

    _pageController.jumpToPage(_currentScreenIndex);
  }

  Widget _getScreen(BuildContext context, int index) {
    int validIndex = _getValidScreenIndex(index);
    if (validIndex == 0) {}
    return _screens[validIndex];
  }
}
