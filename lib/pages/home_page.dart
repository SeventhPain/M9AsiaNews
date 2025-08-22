// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m9_news/l10n/app_localization.dart';
import 'package:m9_news/widgets/contact_bottom_sheet.dart';
import 'package:m9_news/main.dart';
import 'package:m9_news/widgets/language_dialog.dart';
import '../services/api_service.dart';
import '../models/news_model.dart';
import '../models/news_type_model.dart';
import '../models/phone_contact.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/shimmer_effect.dart';
import '../widgets/news_detail.dart';
import '../utils/constants.dart';
import 'privacy_policy.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService(client: http.Client());
  List<News> _news = [];
  List<NewsType> _categories = [];
  List<PhoneContact> _contacts = [];
  NewsType? _selectedCategory;
  bool _isLoading = true;
  String _errorMessage = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final news = await _apiService.fetchNews();
      final categories = await _apiService.fetchNewsTypes();
      final contacts = await _apiService.fetchPhoneContacts();

      setState(() {
        _news = news;
        _categories = categories;
        _contacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _changeLanguage() async {
    final currentLanguage = Localizations.localeOf(context).languageCode;
    final selectedLanguage = await showDialog<String>(
      context: context,
      builder: (context) => LanguageDialog(currentLanguage: currentLanguage),
    );

    if (selectedLanguage != null) {
      MyApp.of(context)?.setLocale(Locale(selectedLanguage));
    }
  }

  void _onCategorySelected(NewsType category) {
    setState(() {
      _selectedCategory = category;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<News> get _filteredNews {
    if (_selectedCategory == null) return _news;
    return _news
        .where((news) => news.newTypeId == _selectedCategory!.id.toString())
        .toList();
  }

  Future<void> _launchUrl(String url, String fallbackUrl) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
        return;
      }

      if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
        await launchUrl(Uri.parse(fallbackUrl));
        return;
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }

  void _openContactOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ContactBottomSheet(contacts: _contacts),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                'images/m9Asia.webp',
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              localizations?.appName ?? 'appName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: _changeLanguage,
            tooltip: localizations?.language ?? 'language',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
            tooltip: localizations?.privacyPolicy ?? 'privacyPolicy',
          ),
        ],
      ),
      body: _isLoading
          ? const NewsShimmer()
          : _errorMessage.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loadData,
                    icon: const Icon(Icons.refresh),
                    label: Text(localizations?.retry ?? 'retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations?.helloReader ?? 'helloReader',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizations?.discoverNews ?? 'discoverNews',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                if (_categories.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations?.categories ?? 'categories',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // All category chip
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedCategory = null),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: _selectedCategory == null
                                        ? AppConstants.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppConstants.primaryColor,
                                      width: 1.5,
                                    ),
                                    boxShadow: _selectedCategory == null
                                        ? [
                                            BoxShadow(
                                              color: AppConstants.primaryColor
                                                  .withOpacity(0.3),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    localizations?.all ?? 'all',
                                    style: TextStyle(
                                      color: _selectedCategory == null
                                          ? Colors.white
                                          : AppConstants.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              // Category chips
                              ..._categories.map(
                                (category) => CategoryChip(
                                  category: category,
                                  isSelected:
                                      _selectedCategory?.id == category.id,
                                  onTap: () => _onCategorySelected(category),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // News list
                Expanded(
                  child: _filteredNews.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                localizations?.noNews ?? 'noNews',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadData,
                          color: AppConstants.primaryColor,
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: _filteredNews.length,
                            itemBuilder: (context, index) {
                              final news = _filteredNews[index];
                              return NewsCard(
                                news: news,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailPage(news: news),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openContactOptions,
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.contact_support),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
