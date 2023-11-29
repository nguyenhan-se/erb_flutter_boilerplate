import 'package:assets/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/services/cache_service.dart';

class CachedNetworkImageCircular extends ConsumerWidget {
  const CachedNetworkImageCircular({
    required this.imageUrl,
    required this.radius,
    this.spareImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/deliverzler.appspot.com/o/public%2Fplaceholder.png?alt=media',
    this.maxHeightDiskCache = 400,
    this.maxWidthDiskCache = 400,
    super.key,
  });
  final String? imageUrl;
  final String spareImageUrl;
  final double radius;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheService = ref.watch(cacheServiceProvider);

    return CachedNetworkImage(
      key: UniqueKey(),
      cacheManager: cacheService.customCacheManager,
      imageUrl: imageUrl != null && imageUrl!.contains('http')
          ? imageUrl!
          : spareImageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircleAvatar(
        radius: radius,
        backgroundImage: AppAssets.images.loading.provider(),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        backgroundImage: AppAssets.images.noInternet.provider(),
      ),
    );
  }
}
