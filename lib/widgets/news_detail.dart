import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/news_model.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: Helpers.getImageUrl(
                "https://gamb.be.prmr.site/storage/${news.coverImage}",
              ),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(
                      news.type.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: AppConstants.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Helpers.formatDate(news.createdAt),
                    style: TextStyle(
                      color: AppConstants.lightTextColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    news.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  // const SizedBox(height: 24),
                  // if (news.filePath.isNotEmpty)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         'Additional Content:',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Image.network(
                  //         Helpers.getImageUrl(
                  //           "https://gamb.be.prmr.site/storage/${news.filePath}",
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
