import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event_form.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Murat Karasakal',
      'subtitle': 'Birthday',
      'date': DateTime.now().add(const Duration(days: 64)), // 🔹 Doğru tarih
    }
  ];

  void _openAddEventForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EventForm(onSave: _addEvent),
    );
  }

  void _addEvent(String title, String subtitle, DateTime date) {
    setState(() {
      _events.add({
        'title': title,
        'subtitle': subtitle,
        'date': date,
      });
    });
  }

  int _calculateRemainingDays(DateTime eventDate) {
    final now = DateTime.now();
    final event = DateTime(eventDate.year, eventDate.month, eventDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return event.difference(today).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          final remainingDays = _calculateRemainingDays(event['date']);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF37C5DA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      event['subtitle'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$remainingDays days\nremaining", // 🔹 Gerçek kalan gün gösteriliyor
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black, // 🔹 Siyah yapıldı
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEventForm,
        backgroundColor: const Color(0xFF37C5DA),
        shape: const CircleBorder(), // 🔹 Tam yuvarlak
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
