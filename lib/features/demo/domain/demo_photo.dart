import 'package:dart_mappable/dart_mappable.dart';

part 'demo_photo.mapper.dart';

@MappableClass()
class DemoPhoto with DemoPhotoMappable {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  DemoPhoto({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  static const fromJson = DemoPhotoMapper.fromJson;
}

@MappableClass()
class DemoAlbum with DemoAlbumMappable {
  final int id;
  final String? title;
  DemoAlbum({
    required this.id,
    this.title,
  });

  static const fromJson = DemoAlbumMapper.fromJson;
}
