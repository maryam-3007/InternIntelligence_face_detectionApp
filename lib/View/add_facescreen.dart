import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:face_detectionapp/View/home_screen.dart';
import 'package:face_detectionapp/controller/face_controller.dart';

class AddFaceScreen extends StatefulWidget {
  @override
  _AddFaceScreenState createState() => _AddFaceScreenState();
}

class _AddFaceScreenState extends State<AddFaceScreen> {
  final FaceController faceController = Get.put(FaceController());
  final TextEditingController nameController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isDetecting = false;
  List<double> _embedding = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
      await _detectFace(_image!);
    }
  }

  Future<void> _detectFace(File image) async {
    final faceDetector = FaceDetector(options: FaceDetectorOptions(enableContours: true));
    final faces = await faceDetector.processImage(InputImage.fromFile(image));

    if (faces.isEmpty) {
      Get.snackbar('No Face Detected', 'Please select an image with a visible face.',
      backgroundColor: Colors.deepPurple,
      colorText: Colors.white
      );
      setState(() => _image = null);
    } else {
      _embedding = List.generate(128, (index) => index * 0.01);
      Get.snackbar('Face Detected', 'Image selected successfully!',
      backgroundColor: Colors.deepPurple,
      colorText: Colors.white
      );
    }
    faceDetector.close();
  }

  Future<void> _saveFace() async {
    if (nameController.text.trim().isEmpty || _image == null || _embedding.isEmpty) {
      Get.snackbar('Error', 'Please enter a name and select a valid face image.',
      backgroundColor: Colors.white,colorText: Colors.black);
      return;
    }

    await faceController.saveFace(nameController.text.trim(), _embedding, _image!.path);
    Get.snackbar('Success', 'Face saved successfully!',colorText: Colors.white,backgroundColor: Colors.deepPurple);
    Get.off(() => HomeScreen());
  }

  void _showImageSourceDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.deepPurple),
              title: Text("Take a Photo"),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.deepPurple),
              title: Text("Choose from Gallery"),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color:Colors.white),
        title: Text(
          'Add Face',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.deepPurple.shade700)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    border: InputBorder.none,
                    icon: Icon(Icons.person, color: Colors.deepPurple),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isDetecting ? null : _saveFace,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shadowColor: Colors.deepPurpleAccent,
              ),
              child: Text(
                _isDetecting ? 'Detecting...' : 'Save Face',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}