import 'package:flutter/cupertino.dart';
import 'package:unsplash_client/unsplash_client.dart';

import 'base_model.dart';

class ModelUnsplashImg extends BaseModel {
  final String accessKey = 'mqkykid9C80zodvTWUSjEsNhqBw4IpXesoRiy2-UELw';
  final String secretKey = 'ATJmWIJWkNao6UDRbEdXilfWDqiUd00zOy-cDwCk38g';
  TextEditingController txtControllerUnsplashImg = TextEditingController();
  List<Photo> _listPhotos = [];

  ModelUnsplashImg();

  Future getImgages() async {
    String searchTerm = txtControllerUnsplashImg.text;
    // Load app credentials from environment variables or file.
    var appCredentials = AppCredentials(accessKey: accessKey, secretKey: secretKey);

    // Create a client.
    final client = UnsplashClient(
      settings: ClientSettings(credentials: appCredentials),
    );
    Response<List<Photo>> response;
    if (searchTerm == null)
      response = await client.photos.random(count: 20).go();
    else
      response = await client.photos.random(query: searchTerm, count: 10).go();

    // Check that the request was successful.
    if (!response.isOk) throw 'Something is wrong: $response';

    _listPhotos = response.data ?? [];
    notifyListeners();
  }

  List<Photo> get listPhotos => _listPhotos;
}
