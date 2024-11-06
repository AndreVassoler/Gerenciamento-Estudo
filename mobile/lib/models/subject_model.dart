class Subject {
  final String name;

  Subject({required this.name});

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json["name"],
    );
  }
}
