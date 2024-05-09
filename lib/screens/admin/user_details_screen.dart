import 'package:flutter/material.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/screens/admin/user_logs_screen.dart';
import 'package:hawk/screens/admin/user_productvity_screen.dart';
import 'package:hawk/screens/admin/user_profile_screen.dart';
import 'package:hawk/widgets/gradientstack.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('User Details'),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    'Records',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Productivity',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserLogsScreen(user: widget.user),
              ProductivityScreen(uid: widget.user.uid),
              UserProfileScreen(user: widget.user),
            ],
          ),
        ),
      ),
    );
  }
}
