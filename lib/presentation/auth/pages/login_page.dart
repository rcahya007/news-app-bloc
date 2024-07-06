import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/styles.dart';
import 'package:news_app/data/datasources/auth_local_datasource.dart';
import 'package:news_app/data/models/request/user_login_request_model.dart';
import 'package:news_app/presentation/auth/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Login Page',
                style: heading,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: 'Email',
                        labelStyle: subHeading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: subHeading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      controller: emailC,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: isPassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: Icon(isPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        labelText: 'Password',
                        labelStyle: subHeading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: subHeading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: passC,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (user) {
                          AuthLocalDatasource().saveAuthData(user);
                          context.goNamed('Home');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(
                                seconds: 2,
                              ),
                              content: Text(
                                'Selamat data ${user.name}',
                                style: subHeading.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          );
                        },
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(
                              seconds: 2,
                            ),
                            content: Text(message),
                          ));
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.blue)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginEvent.login(
                                        UserLoginRequestModel(
                                          email: emailC.text,
                                          password: passC.text,
                                        ),
                                      ),
                                    );
                              }
                            },
                            child: state.maybeWhen(
                              orElse: () {
                                return Text('Login',
                                    style: subHeading.copyWith(
                                      color: whiteColor,
                                    ));
                              },
                              loading: () {
                                return const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: whiteColor,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        // loading: () {
                        //   return const CircularProgressIndicator(
                        //     color: whiteColor,
                        //   );
                        // },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
