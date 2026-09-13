import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        title: const Text(
          'About',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // App name
            const Text(
              'Pocket Pal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Personal Money Manager',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 35),

            // Description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Pocket Pal',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Pocket Pal is a simple personal money management '
                    'app that helps you keep track of your income, '
                    'expenses, balance, and spending categories.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Privacy
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline, color: Colors.black),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Your financial data is stored locally on your device.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Version
            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            const Text(
              'Made for personal finance management',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
