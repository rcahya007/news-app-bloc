import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/presentation/auth/pages/login_page.dart';
import 'package:news_app/presentation/home/bloc/get_news_detail/get_news_detail_bloc.dart';
import 'package:news_app/presentation/home/pages/detail_news_page.dart';
import 'package:news_app/presentation/home/pages/home_page.dart';
import 'package:news_app/presentation/user/pages/profile_page.dart';
import 'package:news_app/presentation/home/pages/saved_articles_page.dart';
import 'package:news_app/presentation/init_page.dart';
import 'package:news_app/presentation/splash_page.dart';

class AppNavigation {
  AppNavigation._();
  static String init = '/splash_screen';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Home
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'HomeNews',
  );
  // Saved
  static final _shellNavigatorSaved = GlobalKey<NavigatorState>(
    debugLabel: 'SavedNews',
  );
  // Profile User
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(
    debugLabel: 'Profile',
  );

  // Go Router Naviagtion
  static final GoRouter router = GoRouter(
      initialLocation: init,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        // InitPage Route
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return InitPage(
              navigationShell: navigationShell,
            );
          },
          branches: [
            // Branch Home
            StatefulShellBranch(navigatorKey: _shellNavigatorHome, routes: [
              GoRoute(
                  path: '/home',
                  name: "Home",
                  builder: (context, state) => const HomePage(),
                  routes: [
                    GoRoute(
                      path: 'detail-news',
                      name: 'DetailNews',
                      builder: (context, state) {
                        return BlocBuilder<GetNewsDetailBloc,
                            GetNewsDetailState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return const SizedBox();
                              },
                              loaded: (article) => DetailNewsPage(
                                article: article,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ]),
            ]),

            // Branch Saved
            StatefulShellBranch(navigatorKey: _shellNavigatorSaved, routes: [
              GoRoute(
                path: '/saved-articles',
                name: "SavedArticles",
                builder: (context, state) => const SavedArticlesPage(),
              ),
            ]),

            // Branch Profile
            StatefulShellBranch(navigatorKey: _shellNavigatorProfile, routes: [
              GoRoute(
                path: '/profile',
                name: "Profile",
                builder: (context, state) => const ProfilePage(),
              ),
            ]),
          ],
        ),

        // Splash Page
        GoRoute(
          path: '/splash_screen',
          name: 'SplashScreen',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SplashPage(),
        ),

        // Login Page
        GoRoute(
          path: '/login',
          name: 'LoginPage',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const LoginPage(),
        ),
      ]);
}
