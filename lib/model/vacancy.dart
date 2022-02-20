class VacancyModel {
  String id;
  String address;
  String daysAgo;
  String employer;
  String minExp;
  String name;
  String obligation;
  String phone;
  String requirements;
  String role;
  String salary;
  String status;
  String telegram;
  String type;
  String workingTime;
  String vacancy;
  dynamic long;
  dynamic lat;

  VacancyModel({
    required this.id,
    required this.address,
    required this.daysAgo,
    required this.employer,
    required this.minExp,
    required this.name,
    required this.obligation,
    required this.phone,
    required this.requirements,
    required this.role,
    required this.salary,
    required this.status,
    required this.telegram,
    required this.type,
    required this.workingTime,
    required this.vacancy,
    required this.lat,
    required this.long,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) => VacancyModel(
        address: json["address"],
        id: json["id"],
        daysAgo: json["days_ago"],
        employer: json["employer"],
        minExp: json["min_exp"],
        name: json["name"],
        obligation: json["obligation"],
        phone: json["phone"],
        requirements: json["requirements"],
        role: json["role"],
        salary: json["salary"],
        status: json["status"],
        telegram: json["telegram"],
        type: json["type"],
        workingTime: json["working_time"],
        vacancy: json["vacancy"],
        lat: json["latitude"],
        long: json["longitude"],
      );
}
