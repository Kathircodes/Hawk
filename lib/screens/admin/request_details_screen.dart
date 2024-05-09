import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appcolors.dart';
import 'package:hawk/appconsts.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/request.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientbutton.dart';
import 'package:hawk/widgets/gradientstack.dart';

class RequestDetailsScreen extends StatefulWidget {
  final Request request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final TextEditingController startTimeController = TextEditingController(text: '9:00 AM');

  final TextEditingController endTimeController = TextEditingController(text: '5:00 PM');

  final TextEditingController startDateController = TextEditingController(
    text:
        "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}",
  );

  final List<String> roleOptions = ['employee', 'manager'];

  String selectedRole = 'employee';

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [AppGradients.screenBg],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: const Text("Accept Request"),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConsts.marginX),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: AppColors.chipBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${widget.request.name}',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email ID: ${widget.request.email}',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'UID: ${widget.request.uid}',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Role: ${widget.request.role}',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_today),
                            labelText: "Start Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            labelStyle: const TextStyle(fontSize: 20, color: Colors.white54),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.green),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          controller: startDateController,
                          readOnly: true,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                final formattedDate =
                                    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                                startDateController.text = formattedDate;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.login),
                            labelText: "Expected Start Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            labelStyle: const TextStyle(fontSize: 20, color: Colors.white54),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.green),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          controller: startTimeController,
                          readOnly: true,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_parseTime(startTimeController.text)),
                            ).then((time) {
                              if (time != null) {
                                startTimeController.text = time.format(context);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.logout),
                            labelText: "Expected Stop Time",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            labelStyle: const TextStyle(fontSize: 20, color: Colors.white54),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.green),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          controller: endTimeController,
                          readOnly: true,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_parseTime(endTimeController.text)),
                            ).then((time) {
                              if (time != null) {
                                endTimeController.text = time.format(context);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRole,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedRole = newValue;
                                  });
                                }
                              },
                              items: roleOptions.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    width: 200, // Set the desired width
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(
                                      value,
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                );
                              }).toList(),
                              dropdownColor: AppColors.aiMessageBubble,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        GradientButton(
                          onPressed: () {
                            String startTimeString = startTimeController.text;
                            String endTimeString = endTimeController.text;

                            DateTime startTime = _parseTime(startTimeString);
                            DateTime endTime = _parseTime(endTimeString);

                            int hours = endTime.hour - startTime.hour;
                            FirestoreService.updateAcceptedUser(
                              widget.request.uid,
                              selectedRole,
                              startDateController.text,
                              startTimeController.text,
                              endTimeController.text,
                              hours,
                              false,
                            );
                            FirestoreService.deleteRequest(
                              widget.request.uid,
                            );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Accept and Update',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

DateTime _parseTime(String timeString) {
  String amOrPm = timeString.substring(timeString.length - 2); // Extract AM/PM
  String time = timeString.substring(0, timeString.length - 3).trim(); // Extract time without AM/PM
  List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  if (amOrPm.toLowerCase() == 'pm' && hour < 12) {
    hour += 12; // Convert PM hours to 24-hour format
  }

  return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
}
