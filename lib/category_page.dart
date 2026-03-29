import 'package:flutter/material.dart';
import 'main.dart'; // Import models (Category & Word)

// WORD PAGE

class WordPage extends StatefulWidget {
  final Category category;

  const WordPage({super.key, required this.category});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  void _addOrEditWord({Word? word}) {
    final wordController =
        TextEditingController(text: word != null ? word.text : '');
    final translationController =
        TextEditingController(text: word != null ? word.translation : '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(word == null ? 'Add Word' : 'Edit Word'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: wordController,
              decoration: const InputDecoration(hintText: 'Word'),
            ),
            TextField(
              controller: translationController,
              decoration: const InputDecoration(hintText: 'Translation'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = wordController.text.trim();
              final translation = translationController.text.trim();
              if (text.isEmpty || translation.isEmpty) return;

              setState(() {
                if (word == null) {
                  widget.category.words.add(Word(text, translation));
                } else {
                  word.text = text;
                  word.translation = translation;
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

  void _deleteWord(Word word) {
    setState(() {
      widget.category.words.remove(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: const Color.fromARGB(255, 195, 161, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.category.words.length,
          itemBuilder: (_, index) {
            final word = widget.category.words[index];

            return Card(
              color: const Color.fromARGB(255, 228, 217, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(
                  word.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(word.translation),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _addOrEditWord(word: word),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteWord(word),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditWord(),
        backgroundColor: const Color.fromARGB(255, 195, 161, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}