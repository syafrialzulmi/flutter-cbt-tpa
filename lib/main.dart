import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/datasources/content_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/datasources/materi_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/datasources/onboarding_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/datasources/ujian_remote_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/pages/login_page.dart';
import 'package:flutter_cbt_tpa/presentation/home/bloc/content/content_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_cbt_tpa/presentation/materi/bloc/materi/materi_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/onboarding/pages/onboarding_page.dart';
import 'package:flutter_cbt_tpa/presentation/quiz/bloc/create_ujian/create_ujian_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/quiz/bloc/ujian_by_kategori/ujian_by_kategori_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ContentBloc(ContentRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => MateriBloc(MateriRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UjianByKategoriBloc(UjianRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateUjianBloc(UjianRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo CBT Tes Potensi Akademik | Syafrial Zulmi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<AuthResponseModel>(
          future: AuthLocalDatasource().getAuthData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardPage();
            } else {
              return FutureBuilder(
                future: OnboardingLocalDatasource().getIsFirstTime(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? const LoginPage()
                        : const OnboardingPage();
                  } else {
                    return const OnboardingPage();
                  }
                },
              );
            }
          },
          // child: const OnboardingPage(),
        ),
      ),
    );
  }
}
