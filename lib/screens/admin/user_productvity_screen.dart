import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/user.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientstack.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProductivityScreen extends StatefulWidget {
  final String uid;

  const ProductivityScreen({super.key, required this.uid});

  @override
  _ProductivityScreenState createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen> {
  late User user;
  late double earlyExitPercentage = 0.0;
  late double lateEntryPercentage = 0.0;
  late double attendancePercentage = 0.0;
  late double workTimePercentage = 0.0;

  @override
  void initState() {
    super.initState();
    // Assuming you have a method to fetch the user data based on the UID
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
      User fetchedUser = User.fromSnapshot(snapshot);
      setState(() {
        user = fetchedUser;
        _calculateProductivity();
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _calculateProductivity() {
    print(user.lateEntryDays);
    List<String> startDateParts = user.startDate.split('/');
    DateTime startDate = DateTime(
      int.parse(startDateParts[2]),
      int.parse(startDateParts[1]),
      int.parse(startDateParts[0]),
    );
    DateTime now = DateTime.now();
    int wdays = 0;
    while (startDate.isBefore(now)) {
      if (startDate.weekday != DateTime.saturday && startDate.weekday != DateTime.sunday) {
        wdays++;
      }
      startDate = startDate.add(const Duration(days: 1));
    }

    earlyExitPercentage = wdays != 0 ? (user.earlyExitDays / wdays) : 0;
    lateEntryPercentage = wdays != 0 ? (user.lateEntryDays / wdays) : 0;
    attendancePercentage = wdays != 0 ? (user.workingDays / wdays) : 0;
    workTimePercentage = wdays != 0 ? (user.workingMinutes / 60).ceil() / (user.expectedWorkHours * wdays) : 0;
  }

  Future<void> _refresh() async {
    await _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    shrinkWrap: true,
                    children: [
                      _buildCircularProgressCard('Early Exit %', earlyExitPercentage, Colors.green),
                      _buildCircularProgressCard('Late Entry %', lateEntryPercentage, Colors.red),
                      _buildCircularProgressCard('Attendance %', attendancePercentage, Colors.blue),
                      _buildCircularProgressCard('Work Time %', workTimePercentage, Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgressCard(String title, double percentage, Color color) {
    return Card(
      color: AppColors.chipBlue,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CircularPercentIndicator(
              radius: 56.0,
              lineWidth: 9.0,
              percent: percentage > 1 ? 1 : percentage,
              center: Text(
                '${(percentage > 1 ? 100 : percentage * 100).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 20),
              ),
              progressColor: color,
            ),
          ],
        ),
      ),
    );
  }
}
