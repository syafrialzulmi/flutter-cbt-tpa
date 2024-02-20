import 'package:flutter/material.dart';
import 'package:flutter_cbt_tpa/data/models/responses/materi_response_model.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/constants/colors.dart';
// import '../models/materi_model.dart';
import '../pages/materi_detail_page.dart';

class MateriCard extends StatelessWidget {
  final Materi data;
  const MateriCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          MateriDetailPage(data: data),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.14),
              blurRadius: 17,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Image.network(
                      data.image,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Gambar telah dimuat
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Center(
                  //   child: CachedNetworkImage(
                  //     imageUrl: data.image,
                  //     width: 100.0,
                  //     height: 100.0,
                  //     fit: BoxFit.cover,
                  //     progressIndicatorBuilder:
                  //         (context, url, downloadProgress) =>
                  //             CircularProgressIndicator(
                  //                 value: downloadProgress.progress),
                  //     errorWidget: (context, url, error) =>
                  //         const Icon(Icons.error),
                  //   ),
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       data.timeAgo,
            //       style: const TextStyle(
            //         color: AppColors.darkGrey,
            //         fontSize: 12,
            //       ),
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.more_horiz),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 20.0),
            Text(
              data.content,
              style: const TextStyle(
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
