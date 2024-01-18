import 'package:flutter/material.dart';
import 'package:flutter_cbt_tpa/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_tpa/presentation/home/pages/about_us_page.dart';
import 'package:flutter_cbt_tpa/presentation/home/pages/tips_and_triks_page.dart';
import 'package:flutter_cbt_tpa/presentation/materi/pages/materi_page.dart';

import '../../../presentation/home/widgets/header_home.dart';
import '../../../presentation/home/widgets/menu_home.dart';
import '../../../presentation/home/widgets/title_section.dart';
import '../../../core/assets/assets.gen.dart';
import '../../quiz/pages/quiz_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HeaderHome(),
          const SizedBox(height: 24.0),
          TitleSection(
            title: 'Beranda',
            onSeeAllTap: () {},
          ),
          const SizedBox(height: 16.0),
          GridView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 24.0,
            ),
            children: [
              MenuHome(
                imagePath: Assets.images.menu.aboutUs.path,
                label: 'Tentang Kami',
                onPressed: () {
                  context.push(const AboutUsPage());
                },
              ),
              MenuHome(
                imagePath: Assets.images.menu.tips.path,
                label: 'Tips & Trik',
                onPressed: () {
                  context.push(const TipsAndTricksPage());
                },
              ),
              MenuHome(
                imagePath: Assets.images.menu.materi.path,
                label: 'Materi',
                onPressed: () {
                  context.push(const MateriPage());
                },
              ),
              MenuHome(
                imagePath: Assets.images.menu.quiz.path,
                label: 'Kuis',
                onPressed: () {
                  context.push(const QuizListPage());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
