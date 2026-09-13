import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Privacy Matters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Last updated: September 2026',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            _buildSection(
              title: '1. Introduction',
              content:
                  'Pocket Pal is a personal money management application '
                  'designed to help you track your income, expenses, balance, '
                  'and spending categories.',
            ),

            _buildSection(
              title: '2. Data Storage',
              content:
                  'Pocket Pal stores your financial and profile information '
                  'locally on your device. Your data is not stored on our '
                  'servers or transmitted to a remote backend.',
            ),

            _buildSection(
              title: '3. Financial Information',
              content:
                  'Information such as income, expenses, transaction '
                  'categories, amounts, dates, and descriptions is used only '
                  'to provide the functionality of the application.',
            ),

            _buildSection(
              title: '4. Personal Information',
              content:
                  'If you provide information such as your name or email '
                  'address, it is stored locally on your device and is used '
                  'only within the application.',
            ),

            _buildSection(
              title: '5. Data Sharing',
              content:
                  'Pocket Pal does not sell, rent, or share your personal or '
                  'financial information with third parties.',
            ),

            _buildSection(
              title: '6. Data Security',
              content:
                  'Because your information is stored locally, the security '
                  'of your device is important. We recommend keeping your '
                  'device protected with a secure lock screen.',
            ),

            _buildSection(
              title: '7. Data Deletion',
              content:
                  'You can remove your locally stored application data by '
                  'deleting the application or using the data management '
                  'options provided within the application, if available.',
            ),

            _buildSection(
              title: '8. Changes to This Policy',
              content:
                  'This Privacy Policy may be updated from time to time. '
                  'Any changes will be reflected on this screen with an '
                  'updated date.',
            ),

            _buildSection(
              title: '9. Contact',
              content:
                  'If you have any questions or concerns about this Privacy '
                  'Policy, please contact the app developer.',
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                'Pocket Pal • Version 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
