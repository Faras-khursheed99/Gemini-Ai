import 'package:api/gemini/gemini_api.dart';
import 'package:api/gemini/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeminiProvider(),
      child: Consumer<GeminiProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Gemini Ai'),
          ),
        ),
      ),
    );
  }
}
