import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cbt_tpa/data/models/responses/materi_response_model.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/components/custom_scaffold.dart';
// import '../models/materi_model.dart';

class MateriDetailPage extends StatelessWidget {
  final Materi data;
  const MateriDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: const Text('Materi TPA'),
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: data.image,
                width: context.deviceWidth,
                height: 470.0,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
            child: Column(
              children: [
                Text(
                  data.content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
