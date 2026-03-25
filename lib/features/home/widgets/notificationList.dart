import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  // Mock data - in a real app, this would come from Firestore
  final List<Map<String, String>> notifications = [
    {
      "title": "Appointment Confirmed",
      "subtitle": "Your visit with Dr. Sarah Smith is scheduled for tomorrow at 10:00 AM.",
      "time": "2h ago"
    },
    {
      "title": "New Message",
      "subtitle": "Dr. Miller sent you a follow-up message regarding your lab results.",
      "time": "5h ago"
    },
    {
      "title": "Health Tip",
      "subtitle": "Don't forget to stay hydrated! Drink at least 8 glasses of water today.",
      "time": "1d ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Keep it flat for a modern look
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.indigo, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.lato(
            color: Colors.indigo[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          return _buildNotificationCard(notifications[index]);
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.04),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.indigo.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue Dot for "Unread" feel
          Container(
            margin: const EdgeInsets.only(top: 5, right: 12),
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['title']!,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.indigo[900],
                      ),
                    ),
                    Text(
                      data['time']!,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  data['subtitle']!,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded, size: 80, color: Colors.indigo[100]),
          const SizedBox(height: 20),
          Text(
            "No notifications yet",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}