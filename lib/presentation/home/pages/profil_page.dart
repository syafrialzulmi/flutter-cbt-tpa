import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa/core/constants/colors.dart';
import 'package:flutter_cbt_tpa/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/pages/login_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: () {
              AuthLocalDatasource().removeAuthData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout Success'),
                  backgroundColor: AppColors.lightGreen,
                ),
              );
              context.pushReplacement(const LoginPage());
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Text('Logout'),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
