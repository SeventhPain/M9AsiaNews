import 'news_type_model.dart'; // Import NewsType first

class NewsResponse {
  final bool success;
  final List<News> data;

  NewsResponse({required this.success, required this.data});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<News> newsList = list.map((i) => News.fromJson(i)).toList();

    return NewsResponse(success: json['success'], data: newsList);
  }
}

class News {
  final int id;
  final String title;
  final String description;
  final String newTypeId;
  final String coverImage;
  final String filePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NewsType type;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.newTypeId,
    required this.coverImage,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      newTypeId: json['book_type_id'],
      coverImage: json['cover_image'],
      filePath: json['file_path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: NewsType.fromJson(json['type']),
    );
  }
}
