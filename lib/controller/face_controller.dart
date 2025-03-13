import 'dart:math';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:face_detectionapp/services/db_helper.dart';
import 'dart:io';

class FaceController extends GetxController {
  var faces = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    loadFaces();
    super.onInit();
  }

  Future<void> saveFace(String name, List<double> embedding, String imagePath) async {
    try {
      await DBHelper.saveFace(name, embedding, File(imagePath).absolute.path);
      await loadFaces();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save face: $e');
    }
  }

  Future<bool> checkFaceExists(List<double> newEmbedding) async {
    List<Map<String, dynamic>> faces = await DBHelper.getFaces();

    for (var face in faces) {
      List<double> existingEmbedding = List<double>.from(jsonDecode(face['embedding']));

      if (_calculateSimilarity(existingEmbedding, newEmbedding) > 0.9) {
        return true;
      }
    }
    return false;
  }

  double _calculateSimilarity(List<double> emb1, List<double> emb2) {
    double dotProduct = 0.0;
    double magnitude1 = 0.0;
    double magnitude2 = 0.0;

    for (int i = 0; i < emb1.length; i++) {
      dotProduct += emb1[i] * emb2[i];
      magnitude1 += emb1[i] * emb1[i];
      magnitude2 += emb2[i] * emb2[i];
    }

    magnitude1 = sqrt(magnitude1);
    magnitude2 = sqrt(magnitude2);

    return (magnitude1 * magnitude2 == 0) ? 0 : dotProduct / (magnitude1 * magnitude2);
  }

  Future<void> loadFaces() async {
    try {
      List<Map<String, dynamic>> rawFaces = await DBHelper.getFaces();
      
      faces.assignAll(rawFaces.map((face) {
        return {
          'id': face['id'],
          'name': face['name'],
          'embedding': List<double>.from(jsonDecode(face['embedding'])), 
          'imagePath': face['imagePath'],
        };
      }).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load faces: $e');
    }
  }

  Future<void> deleteFace(int id) async {
    if (await DBHelper.deleteFace(id) > 0) {
      await loadFaces();
    } else {
      Get.snackbar('Error', 'No face found with ID: $id');
    }
  }
}