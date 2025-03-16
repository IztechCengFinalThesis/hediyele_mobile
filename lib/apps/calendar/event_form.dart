import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final Function(String, String, DateTime) onSave;

  const EventForm({super.key, required this.onSave});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  DateTime? _selectedDate;
  final _dateController = TextEditingController(); // 🔹 Tarih inputu için

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat.yMMMd().format(pickedDate); // 🔹 Seçilen tarihi göster
      });
    }
  }

  void _saveEvent() {
    if (_titleController.text.isEmpty || _selectedDate == null) {
      return;
    }
    widget.onSave(
      _titleController.text.trim(),
      _subtitleController.text.trim(),
      _selectedDate!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // 🔹 Ortalıyoruz
        children: [
          const Text(
            "Add Event",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // 🔹 Ortaladık
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _subtitleController,
            decoration: InputDecoration(
              labelText: "Subtitle",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _pickDate, // 🔹 Tüm alana tıklanınca tarih seçme açılacak
            child: AbsorbPointer(
              child: TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Select Date",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: const Icon(Icons.calendar_today), // 🔹 Sağda ikon var ama tüm alan tıklanabilir
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveEvent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
