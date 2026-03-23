import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recentStatuses = [
    {"name": "Riya", "time": "Today, 8:30 AM", "isNew": true},
    {"name": "Karan", "time": "Yesterday, 7:40 PM", "isNew": true},
  ];

  final List<Map<String, dynamic>> viewedStatuses = [
    {"name": "Aman", "time": "Yesterday, 10:15 PM", "isNew": false},
    {"name": "Meera", "time": "Yesterday, 5:00 PM", "isNew": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔹 AppBar with gradient
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Status",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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

      // 🔹 Body
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // ⭐ My Status Card
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Stack(
                children: [
                  Hero(
                    tag: "myStatus",
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              title: Text(
                "My Status",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Tap to add status update",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
            ),
          ),

          const SizedBox(height: 16),

          // 🆕 Recent Updates
          if (recentStatuses.isNotEmpty) ...[
            sectionTitle("Recent updates"),
            buildStatusSection(recentStatuses),
          ],

          // 👀 Viewed Updates
          if (viewedStatuses.isNotEmpty) ...[
            const SizedBox(height: 16),
            sectionTitle("Viewed updates"),
            buildStatusSection(viewedStatuses),
          ],
        ],
      ),

      // 🔹 Floating Buttons with gradient FAB
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "edit",
            backgroundColor: Colors.white,
            onPressed: () {},
            child: Icon(Icons.edit, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E676), Color(0xFF00C853)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: FloatingActionButton(
              heroTag: "camera",
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {},
              child: const Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // 📌 Status Section with modern card style
  Widget buildStatusSection(List<Map<String, dynamic>> statuses) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: statuses.map((status) => statusTile(status)).toList(),
      ),
    );
  }

  // 📌 Status Tile with gradient border for new statuses
  Widget statusTile(Map<String, dynamic> status) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: status["isNew"]
              ? const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
                )
              : const LinearGradient(colors: [Colors.grey, Colors.grey]),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/profile.png"),
        ),
      ),
      title: Text(
        status["name"],
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        status["time"],
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Icon(
        status["isNew"] ? Icons.chevron_right : Icons.visibility,
        color: status["isNew"] ? Colors.grey[600] : Colors.blueAccent,
      ),
    );
  }
}
