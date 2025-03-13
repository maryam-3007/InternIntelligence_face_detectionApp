import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need Help?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              "If you're facing issues, you can contact us at:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.deepPurple),
              title: Text("Email: support@facedetectionapp.com"),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.deepPurple),
              title: Text("Phone: +123 456 7890"),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.web, color: Colors.deepPurple),
              title: Text("Visit Website"),
              onTap: () {}, 
            ),
          ],
        ),
      ),
    );
  }
}