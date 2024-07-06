import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/styles.dart';
import 'package:news_app/presentation/auth/bloc/check_auth/check_auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        checkAuth();
      },
    );
    super.initState();
  }

  void checkAuth() {
    context.read<CheckAuthBloc>().add(const CheckAuthEvent.check());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckAuthBloc, CheckAuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (isLogin) {
            if (isLogin) {
              context.goNamed('Home');
            } else {
              context.goNamed('LoginPage');
            }
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.newspaper,
                  size: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'News App',
                  style: heading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
