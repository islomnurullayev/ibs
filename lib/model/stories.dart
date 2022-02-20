class StoryModel {
  List contentUrl;
  String avatar;
  String name;
  String role;

  StoryModel({
    required this.contentUrl,
    required this.avatar,
    required this.name,
    required this.role,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        contentUrl: json["contentUrl"],
        avatar: json["user"]["avatar"],
        name: json["user"]["name"],
        role: json["user"]["role"],
      );
}
