class NewsTypeResponse {
  final bool success;
  final List<NewsType> data;

  NewsTypeResponse({required this.success, required this.data});

  factory NewsTypeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NewsType> typeList = list.map((i) => NewsType.fromJson(i)).toList();

    return NewsTypeResponse(success: json['success'], data: typeList);
  }
}

class NewsType {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  NewsType({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsType.fromJson(Map<String, dynamic> json) {
    return NewsType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
