import 'package:face_detectionapp/View/Drawer/about_screen.dart';
import 'package:face_detectionapp/View/add_facescreen.dart';
import 'package:face_detectionapp/View/Drawer/helpandsupport_screen.dart';
import 'package:face_detectionapp/View/Drawer/privacypolicy_screen.dart';
import 'package:face_detectionapp/View/Drawer/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:face_detectionapp/View/face_listscreen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Face Recognition",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(context), // Adding Drawer
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.face_retouching_natural,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            _buildCustomButton(
              icon: Icons.list,
              label: "Manage Stored Faces",
              onTap: () => Get.to(FaceListScreen()),
            ),
            const SizedBox(height: 20),
            _buildCustomButton(
              icon: Icons.camera_alt,
              label: "Start Face Detection",
              onTap: () => Get.to(AddFaceScreen()),
            ),
          ],
        ),
      ),
    );
  }

  
Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Container(
          width: double.infinity, 
          color: Colors.deepPurple, 
          padding: EdgeInsets.symmetric(vertical: 20), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.face_retouching_natural, size: 60, color: Colors.white), 
              SizedBox(height: 10), 
              Text(
                "Face Recognition",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home, color: Colors.deepPurple),
          title: Text("Home"),
          onTap: () {
            Get.back(); 
          },
        ),
        ListTile(
          leading: Icon(Icons.info, color: Colors.deepPurple),
          title: Text("About"),
          onTap: () {
            Get.to(() => AboutScreen());
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: Colors.deepPurple),
          title: Text("Settings"),
          onTap: () {
            Get.to(() => SettingsScreen());
          },
        ),
         ListTile(
          leading: Icon(Icons.lock, color: Colors.deepPurple),
          title: Text("Privacy Policy"),
          onTap: () {
            Get.to(() => PrivacyPolicyScreen());
          },
        ),
         ListTile(
          leading: Icon(Icons.help, color: Colors.deepPurple),
          title: Text("Help and Support"),
          onTap: () {
            Get.to(() => HelpSupportScreen());
          },
        ),
      ],
    ),
  );
}

  Widget _buildCustomButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 24,color: Colors.white,),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}