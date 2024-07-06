import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/datasources/auth_local_datasource.dart';
import 'package:news_app/data/datasources/auth_remote_datasource.dart';
import 'package:news_app/data/datasources/news_remote_datasource.dart';
import 'package:news_app/navigation/app_navigation.dart';
import 'package:news_app/presentation/auth/bloc/check_auth/check_auth_bloc.dart';
import 'package:news_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:news_app/presentation/home/bloc/get_news/get_news_bloc.dart';
import 'package:news_app/presentation/home/bloc/get_news_detail/get_news_detail_bloc.dart';
import 'package:news_app/presentation/user/bloc/get_user_local/get_user_local_bloc.dart';
import 'package:news_app/presentation/user/bloc/logout/logout_bloc.dart';

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
          create: (context) => CheckAuthBloc(AuthLocalDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetNewsBloc(NewsRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetNewsDetailBloc(NewsRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetUserLocalBloc(AuthLocalDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthLocalDatasource()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
