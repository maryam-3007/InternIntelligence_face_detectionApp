import 'package:face_detectionapp/View/Drawer/privacypolicy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            value: isDarkMode,
            onChanged: (value) {
              setState(() => isDarkMode = value);
            },
            secondary: Icon(Icons.dark_mode, color: Colors.deepPurple),
          ),
          SwitchListTile(
            title: Text("Enable Notifications"),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
            },
            secondary: Icon(Icons.notifications, color: Colors.deepPurple),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.deepPurple),
            title: Text("Privacy Policy"),
            onTap: () => Get.to(() => PrivacyPolicyScreen()),
          ),
          
        ],
      ),
    );
  }
}