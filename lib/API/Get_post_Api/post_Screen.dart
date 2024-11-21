import 'package:api/API/Get_post_Api/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Api_PostScreen extends StatefulWidget {
  const Api_PostScreen({super.key});

  @override
  State<Api_PostScreen> createState() => _Api_PostScreenState();
}

class _Api_PostScreenState extends State<Api_PostScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PostProvider(),
        child: Consumer<PostProvider>(
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('api post'),
            ),
            body: Column(
              children: [
                FutureBuilder(
                    future: model.Get_post_api(),
                    builder: (context, Snapshot) {
                      return Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${model.postlist[index].id}'),
                            subtitle: Text('${model.postlist[index].body}'),
                          );
                        }),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
