import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/screens/employee/productivity_screen.dart';
import 'package:hawk/screens/employee/profile_screen.dart';
import 'package:hawk/screens/employee/user_logs.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientstack.dart';

class EmpHomeScreen extends StatefulWidget {
  const EmpHomeScreen({super.key});

  @override
  _EmpHomeScreenState createState() => _EmpHomeScreenState();
}

class _EmpHomeScreenState extends State<EmpHomeScreen> {
  int _currentScreenIndex = 0;
  late User user;
  late List<Widget> _screens = [];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentScreenIndex);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirestoreService.getUserData();
    setState(() {
      user = User.fromSnapshot(snapshot);
      print(user);
      _screens = [
        UserLogsScreen(user: user),
        ProductivityScreen(uid: user.uid),
        ProfileScreen(user: user),
      ];
    });
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
              label: 'Records',
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              label: 'Productivity',
              icon: Icon(EvaIcons.barChart),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(EvaIcons.person),
            ),
          ],
        ),
        body: _screens.isNotEmpty
            ? PageView.builder(
                controller: _pageController,
                onPageChanged: _updateCurrentScreenIndex,
                itemCount: _screens.length,
                itemBuilder: (context, index) {
                  return _screens[index];
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
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

  void _updateCurrentScreenIndex(int value) {
    int validIndex = _getValidScreenIndex(value);

    setState(() {
      _currentScreenIndex = validIndex;
    });
  }

  void _onTapChangeScreen(int value) {
    _updateCurrentScreenIndex(value);

    _pageController.jumpToPage(_currentScreenIndex);
  }
}
