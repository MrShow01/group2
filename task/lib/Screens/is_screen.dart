import 'package:flutter/material.dart';


class IsScreen extends StatelessWidget {
  const IsScreen({super.key});

  final List<Map<String, String>> people = const [
    {"name": "mohammed", "degree": "100"},
    {"name": "felo", "degree": "95"},
    {"name": "amr", "degree": "50"},
    {"name": "abanob", "degree": "90"},
    {"name": "Hanan", "degree": "80"},
  ];

  @override
  Widget build(BuildContext context) {
    final sortedPeople = List<Map<String, String>>.from(people)
      ..sort((a, b) => int.parse(b['degree']!).compareTo(int.parse(a['degree']!)));

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text("Information Systems"),
        backgroundColor: Colors.deepPurple,
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
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(Icons.person, color: Colors.deepPurple.shade800),
              ),
              title: Text(
                person['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text("Degree: ${person['degree']}"),
              trailing: const Icon(Icons.dataset, color: Colors.deepPurple),
            ),
          );
        },
      ),
    );
  }
}
