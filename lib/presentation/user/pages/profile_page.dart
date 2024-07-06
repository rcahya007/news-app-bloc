import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/presentation/user/bloc/get_user_local/get_user_local_bloc.dart';
import 'package:news_app/presentation/user/bloc/logout/logout_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context
        .read<GetUserLocalBloc>()
        .add(const GetUserLocalEvent.getUserLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<GetUserLocalBloc, GetUserLocalState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Text('Something went wrong');
                },
                loaded: (user) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Profile Page'),
                    Text('Name: ${user.name}'),
                    Text('Email: ${user.email}'),
                    Text('Username: ${user.username}'),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<LogoutBloc, LogoutState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: (message) {
                            context.goNamed('LoginPage');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ElevatedButton(
                              onPressed: () {
                                context
                                    .read<LogoutBloc>()
                                    .add(const LogoutEvent.logout());
                              },
                              child: const Text('Logout'),
                            );
                          },
                          loading: () {
                            return const SizedBox(
                              height: 30,
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
