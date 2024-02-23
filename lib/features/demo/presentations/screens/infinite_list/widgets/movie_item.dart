import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:erb_flutter_boilerplate/constants/app_glob_setting.dart';

import '../../../../domain/demo_movie.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({required this.movie, super.key});
  final DemoMovie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: CachedNetworkImage(
              imageUrl: '${AppGlobalSetting.tmdbImg}/${movie.posterPath}',
              placeholder: (context, url) => const SizedBox(
                width: 70,
                height: 110,
              ),
              width: 70,
              height: 110,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                width: 70,
                height: 110,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    movie.originalTitle ?? '',
                    maxLines: 1,
                  ),
                  Text(
                    maxLines: 2,
                    movie.overview ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              value: movie.voteAverage ?? 0 / 10,
                            ),
                          ),
                          Text(
                            '${(movie.voteAverage ?? 0 * 10).floor()}%',
                          ),
                        ],
                      ),
                      Text(
                        'Released ${movie.releaseDate}',
                      ),
                      Text(
                        '${movie.voteCount} Votes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
