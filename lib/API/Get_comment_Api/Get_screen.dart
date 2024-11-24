import 'package:api/API/Get_comment_Api/Get_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Get_Comment extends StatefulWidget {
  const Get_Comment({super.key});

  @override
  State<Get_Comment> createState() => _Get_CommentState();
}

class _Get_CommentState extends State<Get_Comment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetProvider(),
      child: Consumer<GetProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Comment Api"),
          ),
          body: Column(
            children: [
              FutureBuilder(
                  future: model.get_comment_api(),
                  builder: (context, Snapshot) {
                    return Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${model.getlist[index].id}'),
                        subtitle: Text('${model.getlist[index].id}'),
                      );
                    }));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
