import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text('About App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color:Colors.white),
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.face_retouching_natural,
                  size: 100,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'FaceTrace',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 5),
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Divider(thickness: 1, height: 30),
              Text(
                'This app allows users to detect and recognize faces using machine learning. It helps in face identification and management with real-time camera support.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                'Key Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              FeatureItem('Real-time Face Detection'),
              FeatureItem('Camera & Gallery Image Support'),
              FeatureItem('User-friendly Interface with GetX'),
              FeatureItem('Secure Face Data Storage'),
              SizedBox(height: 20),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text(
                'Developed by:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 5),
              Text(
                'Maryam Ilyas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Flutter Developer',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


class FeatureItem extends StatelessWidget {
  final String text;
  FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.deepPurple, size: 22),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}