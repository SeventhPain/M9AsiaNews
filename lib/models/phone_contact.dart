class PhoneContact {
  final int id;
  final String name;
  final String telegram;
  final String viber;
  final String contactUrl;
  final String description;

  PhoneContact({
    required this.id,
    required this.name,
    required this.telegram,
    required this.viber,
    required this.contactUrl,
    required this.description,
  });

  factory PhoneContact.fromJson(Map<String, dynamic> json) {
    return PhoneContact(
      id: json['id'],
      name: json['name'] ?? '',
      telegram: json['telegram'] ?? '',
      viber: json['viber'] ?? '',
      contactUrl: json['contact_url'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
