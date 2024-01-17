import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa/data/datasources/auth_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/datasources/onboarding_local_datasource.dart';
import 'package:flutter_cbt_tpa/data/models/responses/auth_response_model.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_cbt_tpa/presentation/auth/pages/login_page.dart';
import 'package:flutter_cbt_tpa/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_cbt_tpa/presentation/onboarding/pages/onboarding_page.dart';

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
