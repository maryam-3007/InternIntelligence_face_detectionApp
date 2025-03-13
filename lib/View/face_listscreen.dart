import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:face_detectionapp/controller/face_controller.dart';

class FaceListScreen extends StatelessWidget {
  final FaceController faceController = Get.put(FaceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Faces', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (faceController.faces.isEmpty) {
          return Center(
            child: Text(
              'No faces saved',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: faceController.faces.length,
          itemBuilder: (context, index) {
            var face = faceController.faces[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple[100],
                  backgroundImage: face['imagePath'] != null && face['imagePath'].isNotEmpty
                      ? FileImage(File(face['imagePath']))
                      : null,
                  child: face['imagePath'] == null || face['imagePath'].isEmpty
                      ? Icon(Icons.person, color: Colors.white, size: 30)
                      : null,
                ),
                title: Text(
                  face['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Embedding: ${face['embedding'].toString().substring(0,30)}...',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context,face['id']);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
void _showDeleteConfirmationDialog(BuildContext context, faceId) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          SizedBox(width: 10),
          Text(
            'Delete Face?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to delete this saved face? This action cannot be undone.',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            await faceController.deleteFace(faceId);
            Get.snackbar(
              'Success',
              'Face Deleted',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.deepPurple,
              colorText: Colors.white,
              margin: EdgeInsets.all(10),
              icon: Icon(Icons.check_circle, color: Colors.white),
              duration: Duration(seconds: 2),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Yes, Delete',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
    barrierDismissible: false, 
  );
}
}