import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contract List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  List<Map<String, String>> contacts = [];

  void _saveContact() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      setState(() {
        contacts.add({
          'name': nameController.text,
          'number': numberController.text,
        });
        contacts.sort((a, b) => a['name']!.compareTo(b['name']!));
        nameController.clear();
        numberController.clear();
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Contract List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Number',
                  border: OutlineInputBorder(),
                  hintText: 'Enter number',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: _saveContact,
                  child: const Text(
                    'Save Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[300],
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        contacts[index]['name']!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(contacts[index]['number']!),
                      trailing: const Icon(Icons.call),
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Contact'),
                          content: const Text('Are you sure you want to delete this contact?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.delete_forever),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteContact(index);
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
