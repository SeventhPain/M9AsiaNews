// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/phone_contact.dart';

class ContactBottomSheet extends StatelessWidget {
  final List<PhoneContact> contacts;

  const ContactBottomSheet({Key? key, required this.contacts})
    : super(key: key);

  Widget _buildMessengerButton({
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Future<void> _launchViber(String phoneNumber, BuildContext context) async {
    try {
      // Viber URL schemes
      final viberAddUrl = 'viber://add?number=$phoneNumber';
      final viberChatUrl = 'viber://chat?number=$phoneNumber';
      final viberFallback = 'https://www.viber.com';

      print('Attempting to launch Viber with: $viberAddUrl');

      // Try direct launch without canLaunchUrl check first
      try {
        final launched = await launchUrl(
          Uri.parse(viberAddUrl),
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          print('Viber launched successfully');
          return;
        }
      } catch (e) {
        print('Direct launch failed: $e');
      }

      // If direct launch failed, try alternative URL schemes
      try {
        final launched = await launchUrl(
          Uri.parse(viberChatUrl),
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          print('Viber chat launched successfully');
          return;
        }
      } catch (e) {
        print('Chat launch failed: $e');
      }

      // If all custom schemes fail, try the fallback
      if (await canLaunchUrl(Uri.parse(viberFallback))) {
        await launchUrl(
          Uri.parse(viberFallback),
          mode: LaunchMode.externalApplication,
        );
        print('Opened Viber website');
      } else {
        _showErrorSnackbar(context, "Please install Viber to use this feature");
      }
    } catch (e) {
      print("Error launching Viber: $e");
      _showErrorSnackbar(context, "Cannot open Viber");
    }
  }

  Future<void> _launchTelegram(String username, BuildContext context) async {
    try {
      // Remove @ if present and any whitespace
      final cleanUsername = username.replaceAll('@', '').trim();

      // Telegram app URL scheme
      final telegramAppUrl = 'tg://resolve?domain=$cleanUsername';
      // Web fallback
      final telegramWebUrl = 'https://t.me/$cleanUsername';

      print('Attempting to launch Telegram with: $telegramAppUrl');

      // Try to open the Telegram app first
      try {
        final launched = await launchUrl(
          Uri.parse(telegramAppUrl),
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          print('Telegram app launched successfully');
          return;
        }
      } catch (e) {
        print('Telegram app launch failed: $e');
      }

      // If the app is not installed, fall back to the web version
      print('Falling back to web version: $telegramWebUrl');
      if (await canLaunchUrl(Uri.parse(telegramWebUrl))) {
        await launchUrl(
          Uri.parse(telegramWebUrl),
          mode: LaunchMode.externalApplication,
        );
        print('Opened Telegram web');
      } else {
        _showErrorSnackbar(
          context,
          "Please install Telegram to use this feature",
        );
      }
    } catch (e) {
      print("Error launching Telegram: $e");
      _showErrorSnackbar(context, "Cannot open Telegram");
    }
  }

  Future<void> _launchContactUrl(String url, BuildContext context) async {
    try {
      // Clean up the URL - remove any quotes or extra spaces
      final cleanUrl = url.replaceAll('"', '').trim();

      // Ensure the URL has a proper scheme
      final Uri uri;
      if (cleanUrl.startsWith('http://') || cleanUrl.startsWith('https://')) {
        uri = Uri.parse(cleanUrl);
      } else {
        uri = Uri.parse('https://$cleanUrl');
      }

      print('Attempting to launch URL: $uri');

      // Try to launch directly first
      try {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          print('URL launched successfully');
          return;
        }
      } catch (e) {
        print('Direct launch failed: $e');
      }

      // If direct launch fails, try with canLaunchUrl check
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackbar(
          context,
          "Cannot open the link. No app available to handle this URL.",
        );
      }
    } catch (e) {
      print("Error launching contact URL: $e");
      _showErrorSnackbar(context, "An error occurred while opening the link");
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text("No contact info available")),
      );
    }

    final contact = contacts.first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ဆက်သွယ်ရန်',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Full-width "Click This Link" button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Remove the string interpolation to avoid adding quotes
                _launchContactUrl(contact.contactUrl, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Click This Link",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Telegram & Viber buttons side by side
          Row(
            children: [
              _buildMessengerButton(
                icon: Icons.send,
                color: const Color(0xFF0088CC),
                text: "Telegram",
                onTap: () {
                  Navigator.pop(context);
                  _launchTelegram('${contact.telegram}', context);
                },
              ),
              const SizedBox(width: 12),
              _buildMessengerButton(
                icon: Icons.message,
                color: const Color(0xFF665CAC),
                text: "Viber",
                onTap: () {
                  Navigator.pop(context);
                  // Extract phone number from Viber URL or use directly
                  final viberUrl = '${contact.viber}';
                  final phoneNumber =
                      _extractPhoneNumber(viberUrl) ?? '${contact.viber}';
                  _launchViber(phoneNumber, context);
                },
              ),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  String? _extractPhoneNumber(String viberUrl) {
    try {
      final uri = Uri.parse(viberUrl);
      final phoneNumber = uri.queryParameters['number'];
      return phoneNumber;
    } catch (e) {
      return null;
    }
  }
}
