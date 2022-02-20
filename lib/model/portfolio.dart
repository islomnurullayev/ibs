import 'package:cloud_firestore/cloud_firestore.dart';

class PortfolioModel {
  String id;
  String title;
  String type;
  String description;
  List contents;
  String name;
  List comments;
  String role;
  int viewed;
  int likes;
  Timestamp createdAt;

  PortfolioModel({
    required this.id,
    required this.description,
    required this.title,
    required this.type,
    required this.contents,
    required this.name,
    required this.role,
    required this.viewed,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        description: json["description"],
        contents: json["contents"],
        name: json["user"]["name"],
        role: json["user"]["role"],
        viewed: json["viewed"],
        likes: json["like_count"],
        createdAt: json["created_at"],
        comments: json["comments"],
      );
}
