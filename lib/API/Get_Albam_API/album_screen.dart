import 'package:api/API/Get_Albam_API/album_provider.dart';
import 'package:api/API/Get_Albam_API/get_album_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlbumProvider(),
      child: Consumer<AlbumProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Album Api'),
          ),
          body: Column(
            children: [
              FutureBuilder(
                future: model.getAlbumapi(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: model.albumlist.length,
                        itemBuilder: (context, index) {
                          var album = model.albumlist[index];
                          return ListTile(
                            title: Text('${model.albumlist[index].id}'),
                            subtitle: Text('${model.albumlist[index].title}'),
                          );
                        }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
