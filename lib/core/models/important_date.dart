class ImportantDate {
  String id;
  String title;
  DateTime date;
  bool requiredDate;

  ImportantDate({
    required this.id,
    required this.title,
    required this.date,
    this.requiredDate = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'required': requiredDate,
    };
  }

  factory ImportantDate.fromJson(Map<String, dynamic> json) {
    return ImportantDate(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as DateTime,
      requiredDate: json['required'] as bool,
    );
  }

  factory ImportantDate.empty() => ImportantDate(
        id: '',
        title: '',
        date: DateTime.now(),
      );
}
