import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Header with gradient + profile
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.edit, color: Colors.purple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Aarasee Sharma",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "@aarasee",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Flutter Developer | Living the code ✨",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard("Chats", "120"),
                  _buildStatCard("Calls", "45"),
                  _buildStatCard("Status", "32"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Info Section
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE1F5FE), Color(0xFFF3E5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildInfoRow(Icons.phone, "Phone", "+91 98765 43210"),
                  _buildInfoRow(Icons.email, "Email", "aarasee@example.com"),
                  _buildInfoRow(
                    Icons.info_outline,
                    "About",
                    "Building modern Flutter apps ❤️",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Settings Options
            _buildSettingTile(Icons.lock, "Privacy", Colors.purple),
            _buildSettingTile(
              Icons.notifications,
              "Notifications",
              Colors.blue,
            ),
            _buildSettingTile(Icons.color_lens, "Theme", Colors.teal),
            _buildSettingTile(Icons.help, "Help & Support", Colors.orange),
            _buildSettingTile(
              Icons.logout,
              "Logout",
              Colors.red,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Stat Card Widget
  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // 🔹 Info Row
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Settings Tile
  Widget _buildSettingTile(
    IconData icon,
    String title,
    Color color, {
    bool isLogout = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: isLogout ? FontWeight.bold : FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
