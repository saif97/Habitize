import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_models/model_unsplash_img.dart';

class ScreenUnsplashImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => ModelUnsplashImg(), child: SafeArea(child: _Main())));
  }
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ModelUnsplashImg model = Provider.of(context);

    return model.listPhotos == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (txt) => model.txtControllerUnsplashImg.text = txt,
                        decoration: const InputDecoration.collapsed(hintText: "Search..."),
                      ),
                    ),
                  ),
                  FlatButton(onPressed: () => model.getImgages(), child: Icon(Icons.search)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.listPhotos.length,
                  itemBuilder: (context, i) {
                    final photo = model.listPhotos[i];
                    return InkWell(
                      onTap: () => Navigator.pop(context, photo.urls.small.toString()),
                      child: CachedNetworkImage(
                        imageUrl: photo.urls.small.toString(),
                        placeholder: (context, url) => Container(height: photo.height.toDouble()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }
}
