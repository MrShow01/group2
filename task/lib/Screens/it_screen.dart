import 'package:flutter/material.dart';


class ItScreen extends StatelessWidget {
  const ItScreen({super.key});

  final List<Map<String, String>> people = const [
    {"name": "mohammed", "degree": "70"},
    {"name": "felo", "degree": "80"},
    {"name": "amr", "degree": "60"},
    {"name": "abanob", "degree": "100"},
    {"name": "Hanan", "degree": "85"},
  ];

  @override
  Widget build(BuildContext context) {
    final sortedPeople = List<Map<String, String>>.from(people)
      ..sort((a, b) => int.parse(b['degree']!).compareTo(int.parse(a['degree']!)));

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text("Information Technology"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sortedPeople.length,
        itemBuilder: (context, index) {
          final person = sortedPeople[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Icon(Icons.person, color: Colors.indigo.shade800),
              ),
              title: Text(
                person['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text("Degree: ${person['degree']}"),
              trailing: const Icon(Icons.computer, color: Colors.indigo),
            ),
          );
        },
      ),
    );
  }
}
