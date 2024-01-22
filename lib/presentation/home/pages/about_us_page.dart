import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_tpa/presentation/home/bloc/content/content_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import '../../../core/assets/assets.gen.dart';
import '../../../core/components/custom_scaffold.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    context.read<ContentBloc>().add(const ContentEvent.getContentById('1'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: const Text('About US'),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            success: (contentResponseModel) {
              return ListView(
                children: [
                  // Assets.images.menu.aboutUs.image(),
                  contentResponseModel.data.isEmpty
                      ? const SizedBox()
                      : Center(
                          child: CachedNetworkImage(
                            imageUrl: contentResponseModel.data[0].image,
                            width: context.deviceWidth,
                            height: 470.0,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
                    child: Text(
                      contentResponseModel.data[0].title,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
