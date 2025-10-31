import 'package:flutter/material.dart';


class CsScreen extends StatelessWidget {
  const CsScreen({super.key});

  final List<Map<String, String>> people = const [
    {"name": "mohammed", "degree": "90"},
    {"name": "felo", "degree": "70"},
    {"name": "amr", "degree": "80"},
    {"name": "abanob", "degree": "85"},
    {"name": "Hanan", "degree": "100"},
  ];

  @override
  Widget build(BuildContext context) {
    final sortedPeople = List<Map<String, String>>.from(people)
      ..sort((a, b) => int.parse(b['degree']!).compareTo(int.parse(a['degree']!)));

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Computer Science"),
        backgroundColor: Colors.teal,
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
                backgroundColor: Colors.teal.shade100,
                child: Icon(Icons.person, color: Colors.teal.shade800),
              ),
              title: Text(
                person['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text("Degree: ${person['degree']}"),
              trailing: const Icon(Icons.memory, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}
