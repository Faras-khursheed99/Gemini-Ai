import 'package:api/API/Get_Photo_Api/photo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoScreenApi extends StatefulWidget {
  const PhotoScreenApi({super.key});

  @override
  State<PhotoScreenApi> createState() => _PhotoScreenApiState();
}

class _PhotoScreenApiState extends State<PhotoScreenApi> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhotoProvider(),
      child: Consumer<PhotoProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Photo Api'),
          ),
          body: Column(
            children: [
              FutureBuilder(
                  future: model.getalbumapi(),
                  builder: (context, Snapshot) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: model.photolist.length,
                          itemBuilder: (context, index) {
                            var photo = model.photolist[index];
                            return ListTile(
                              title: Text('${model.photolist[index].id}'),
                              subtitle: Text('${model.photolist[index].title}'),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
