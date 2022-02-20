class CourseModel {
  int id;
  String title;
  String type;
  String color;
  String author;
  bool saved;
  bool viewed;
  int progress;
  int coursesCount;
  int duration;
  List courses;
  bool recommended;
  dynamic projects;
  dynamic comments;
  // String video;

  CourseModel({
    required this.id,
    required this.title,
    required this.type,
    required this.color,
    required this.author,
    required this.saved,
    required this.viewed,
    required this.progress,
    required this.coursesCount,
    required this.duration,
    required this.courses,
    required this.recommended,
    required this.projects,
    required this.comments,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        color: json["color"],
        author: json["user"]["name"],
        saved: json["saved"],
        viewed: json["viewed"],
        progress: json["progress"],
        coursesCount: json["courses_count"],
        duration: json["duration"],
        courses: json["videos"],
        recommended: json["recommended"],
        projects: json["projects"],
        comments: json["comments"],
      );

  Map<String, dynamic> get toJson => {
        "id": id,
        "title": title,
        "type": type,
        "color": color,
        "author": author,
        "saved": saved,
        "viewed": viewed,
        "progress": progress,
        "coursesCount": coursesCount,
        "duration": duration,
        "courses": courses,
      };
}
