class ResourceModel {
  List topics;
  List filter;
  String caption;
  String color;
  String name;
  String id;

  ResourceModel({
    required this.id,
    required this.topics,
    required this.caption,
    required this.color,
    required this.name,
    required this.filter,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
        topics: json["topics"],
        id: json["id"],
        caption: json["caption"],
        color: json["color"],
        name: json["name"],
        filter: json["filter"],
      );
}
