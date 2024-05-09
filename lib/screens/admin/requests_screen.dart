import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawk/appgradient.dart';
import 'package:hawk/models/request.dart';
import 'package:hawk/screens/admin/request_details_screen.dart';
import 'package:hawk/services/firestore_service.dart';
import 'package:hawk/widgets/gradientstack.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientStack(
      gradients: const [
        AppGradients.screenBg,
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text("List of Signup Requests"),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const Text(
                //   "List of Signup Requests",
                //   style: TextStyle(fontSize: 22),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('requests').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          'No signup requests available',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    List<Request> requests = snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                      return Request(
                        uid: data['uid'],
                        name: data['name'],
                        email: data['email'],
                        status: data['status'],
                        inOffice: data['in_office'],
                        role: data['role'],
                      );
                    }).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        Request request = requests[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Card(
                            color: const Color(0xFF044E6A),
                            child: ListTile(
                              title: Text(
                                request.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                request.email,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RequestDetailsScreen(request: request),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade600),
                                    ),
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Reject Request"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Email: ${request.email}",
                                                  style: TextStyle(
                                                      color: Colors.red.shade600,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 8.0),
                                                const Text(
                                                  "Are you sure you want to reject this request?",
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Logic to reject the request
                                                  FirestoreService.updateRejectedUser(request.uid);
                                                  FirestoreService.deleteRequest(request.uid);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Reject",
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600),
                                    ),
                                    child: const Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class RequestDetailsScreen extends StatelessWidget {
//   final Request request;

//   const RequestDetailsScreen({super.key, required this.request});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Request Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Name: ${request.name}'),
//             Text('Email: ${request.email}'),
//             Text('Status: ${request.status}'),
//             Text('In Office: ${request.inOffice}'),
//             Text('Role: ${request.role}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
