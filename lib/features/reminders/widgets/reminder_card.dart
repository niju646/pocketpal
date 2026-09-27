import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String title;
  final double amount;
  final String date;
  final VoidCallback? ondelete;
  const ReminderCard({
    super.key,
    required this.amount,
    required this.date,
    required this.title,
    this.ondelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Red Accent Indicator Bar
              Container(width: 5, color: const Color(0xFFC5221F)),

              // Main Card Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 15,
                                      color: Color(0xFF64748B),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Right Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹$amount',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  InkWell(
                                    onTap: ondelete,
                                    child: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 18,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                'Fixed billing',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Divider(
                        height: 1,
                        thickness: 0.8,
                        color: Color(0xFFF1F5F9),
                      ),

                      const SizedBox(height: 12),

                      // Bottom Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Rollover Text
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.autorenew_rounded,
                                  size: 16,
                                  color: Color(0xFF0D7A5F),
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Will roll over to 18 Nov next',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Mark Paid Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Action on mark paid click
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF006D44),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.check_circle_outline,
                              size: 16,
                            ),
                            label: const Text(
                              'Mark Paid',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
