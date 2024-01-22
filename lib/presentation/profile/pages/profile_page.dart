import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/logout/logout_bloc.dart';
import '../../../core/extensions/build_context_ext.dart';

import '../../../core/components/custom_scaffold.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: false,
      toolbarHeight: 110.0,
      appBarTitle: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: 'https://i.pravatar.cc/200',
                width: 64.0,
                height: 64.0,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width: context.deviceWidth - 160.0,
            child: FutureBuilder<AuthResponseModel>(
              future: AuthLocalDatasource().getAuthData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo, ${snapshot.data!.user.name}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot.data!.user.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {
          //     context.pushAndRemoveUntil(const LoginPage(), (route) => false);
          //   },
          //   icon: Assets.icons.logout.image(width: 24.0),
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          ProfileMenu(
            label: 'Edit Profile',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Help',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Privacy & Policy',
            onPressed: () {},
          ),
          ProfileMenu(
            label: 'Term of Service',
            onPressed: () {},
          ),
          const SizedBox(height: 16.0),
          ProfileMenu(
            label: 'Logout',
            onPressed: () {
              context.read<LogoutBloc>().add(const LogoutEvent.logout());
              // AuthLocalDatasource().removeAuthData();
              context.pushReplacement(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
