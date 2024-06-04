class TypeArticle {
  int? id;
  String nom;
  String description;
  TypeArticle({this.id, required this.nom, required this.description});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "description": description,
    };
  }

  factory TypeArticle.fromMap(Map<String, dynamic> map) {
    return TypeArticle(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      );
  }
}
