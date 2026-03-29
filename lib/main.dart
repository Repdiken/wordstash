import 'package:flutter/material.dart';
import 'category_page.dart'; // Import the WordPage
// data models
class Word {
  String text;
  String translation;

  Word(this.text, this.translation);
}

class Category {
  String name;
  List<Word> words = [];

  Category(this.name);
}

void main() {
  runApp(const WordstashApp()); // Lauching the widget tree
}

class WordstashApp extends StatelessWidget {
  const WordstashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordstash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const CategoryPage(),
    );
  }
}

// CATEGORY PAGE

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState(); // private class
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Category> categories = [];

  void _addOrEditCategory({Category? category}) {
    final controller = // if category is null, it's an add operation, otherwise it's an edit
        TextEditingController(text: category != null ? category.name : '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(category == null ? 'Add Category' : 'Edit Category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Language name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim(); // trim to remove extra spaces
              if (name.isEmpty) return;

              setState(() { // rebuild the UI
                if (category == null) {
                  categories.add(Category(name));
                } else {
                  category.name = name;
                }
              });

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(Category category) {
    setState(() {
      categories.remove(category);
    });
  }

  @override //return the UI
  Widget build(BuildContext context) {
    return Scaffold( // page structure
      appBar: AppBar(
        title: const Text('Wordstash'),
        backgroundColor: const Color.fromARGB(255, 195, 161, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (_, index) {
            final category = categories[index];

            return Card(
              color: const Color.fromARGB(255, 228, 217, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(
                  category.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _addOrEditCategory(category: category),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteCategory(category),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WordPage(category: category),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditCategory(),
        backgroundColor: const Color.fromARGB(255, 195, 161, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}