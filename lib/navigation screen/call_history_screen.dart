import 'package:flutter/material.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  // Dummy data
  final List<Map<String, dynamic>> calls = const [
    {
      "name": "Aarasee",
      "time": "Today, 11:30 AM",
      "isVideo": false,
      "incoming": true,
    },
    {
      "name": "Rahul",
      "time": "Yesterday, 9:15 PM",
      "isVideo": true,
      "incoming": false,
    },
    {
      "name": "Neha",
      "time": "Yesterday, 5:45 PM",
      "isVideo": false,
      "incoming": true,
    },
    {
      "name": "Amit",
      "time": "12 Aug, 3:20 PM",
      "isVideo": true,
      "incoming": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00BCD4), Color(0xFF2196F3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(3), // logo ke around border
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("asset/logo.png"), // apna logo
              ),
            ),
          ),
        ),

        title: const Text(
          "Call History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                  ),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Text(
                    call['name'][0],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ),
              ),
              title: Text(
                call['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    call['incoming'] ? Icons.call_received : Icons.call_made,
                    size: 18,
                    color: call['incoming'] ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    call['time'],
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  call['isVideo'] ? Icons.videocam_rounded : Icons.call_rounded,
                  color: const Color(0xFF2196F3),
                  size: 24,
                ),
              ),
              onTap: () {
                // Call details ya redial
              },
            ),
          );
        },
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            // Add new call action
          },
          child: const Icon(
            Icons.add_ic_call_rounded,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
