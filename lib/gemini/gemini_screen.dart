import 'package:api/gemini/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add dependency for spin kit

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  TextEditingController search = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('history') ?? [];
    });
  }

  Future<void> saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', history);
  }

  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    setState(() {
      history = [];
    });
  }

  void addToHistory(String question) {
    setState(() {
      history.add(question);
    });
    saveHistory();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Show history dialog
  void showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Questions History"),
        content: history.isEmpty
            ? const Text("No questions asked yet.")
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: history
                      .map((question) => Text("- $question",
                          style: const TextStyle(fontSize: 16)))
                      .toList(),
                ),
              ),
        actions: [
          TextButton(
            onPressed: () {
              clearHistory(); // Clear history
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text(
              "Clear History",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeminiProvider(),
      child: Consumer<GeminiProvider>(
        builder: (context, model, child) {
          // Scroll to the bottom when new messages arrive
          if (model.message.isNotEmpty) {
            scrollToBottom();
          }

          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text('Gemini AI'),
              actions: [
                IconButton(
                  onPressed: () => showHistoryDialog(context),
                  icon: const Icon(Icons.history),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: model.message.length +
                        (model.isLoading
                            ? 1
                            : 0), // Add an extra item if loading
                    itemBuilder: (context, index) {
                      // Display loading indicator as the last item if it's still loading
                      if (model.isLoading && index == model.message.length) {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 30.0,
                          ),
                        );
                      }

                      bool isUserMessage = index % 2 == 0;

                      return Align(
                        alignment: isUserMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUserMessage
                                ? const Color.fromARGB(255, 238, 242, 246)
                                : const Color.fromARGB(255, 229, 244, 229),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            model.message[index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: search,
                          decoration: InputDecoration(
                            hintText: "Enter your question...",
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (search.text.isNotEmpty) {
                            model.geminiresponse(search.text.toString());
                            addToHistory(search.text.toString());
                            search.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
