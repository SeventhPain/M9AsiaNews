// lib/screens/privacy_policy_page.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Last Updated: January 1, 2024',
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: Colors.grey,
            //     fontStyle: FontStyle.italic,
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'M9 Asia is a news application that provides users with the latest news content. We value your privacy and are committed to being transparent about our practices.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('No Data Collection'),
            _buildSectionContent(
              'This application does not collect, store, or share any personal information from users. We do not require registration or any form of personal data to use our app.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('News Content'),
            _buildSectionContent(
              'The app displays news content fetched from external sources. We are not responsible for the content of external websites or news sources.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Permissions'),
            _buildSectionContent(
              'This application does not require any special permissions on your device as it does not access personal data, camera, microphone, or location services.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Changes to This Policy'),
            _buildSectionContent(
              'If we change our privacy practices, we will update this privacy policy and change the last updated date at the top of this document.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Us'),
            _buildSectionContent(
              'If you have any questions about this Privacy Policy, please contact us at info@m9asia.com.',
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Thank you for using M9 Asia',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(content, style: const TextStyle(fontSize: 16, height: 1.5));
  }
}
