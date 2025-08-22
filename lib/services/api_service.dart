import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m9_news/models/phone_contact.dart';
import '../models/news_model.dart';
import '../models/news_type_model.dart';
import 'exception.dart';

class ApiService {
  static const String baseUrl = 'https://gamb.be.prmr.site/api/v1';

  final http.Client client;

  ApiService({required this.client});

  Future<List<News>> fetchNews() async {
    final response = await client.get(Uri.parse('$baseUrl/books'));

    if (response.statusCode == 200) {
      final newsResponse = NewsResponse.fromJson(json.decode(response.body));
      return newsResponse.data;
    } else {
      throw NewsException('Failed to load news');
    }
  }

  Future<List<NewsType>> fetchNewsTypes() async {
    final response = await client.get(Uri.parse('$baseUrl/booktypes'));

    if (response.statusCode == 200) {
      final typeResponse = NewsTypeResponse.fromJson(
        json.decode(response.body),
      );
      return typeResponse.data;
    } else {
      throw NewsException('Failed to load news types');
    }
  }

  Future<List<PhoneContact>> fetchPhoneContacts() async {
    final url = Uri.parse("https://gamb.be.prmr.site/api/v1/phones");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['success'] == true) {
        final List data = body['data'];
        return data.map((e) => PhoneContact.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load contacts");
      }
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }
}
