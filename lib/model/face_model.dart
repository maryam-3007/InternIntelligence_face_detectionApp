class FaceModel {
  final int? id;
  final String name;
  final String imagePath;
  final String embedding;

  FaceModel({this.id, required this.name, required this.imagePath, required this.embedding});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'imagePath': imagePath, 'embedding': embedding};
  }

  factory FaceModel.fromMap(Map<String, dynamic> map) {
    return FaceModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      embedding: map['embedding'],
    );
  }
}