import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_clicks/modules/homepage/model/movies_data.models.dart';
import 'package:movies_clicks/modules/homepage/screens/homepage.screens.dart';
import 'package:movies_clicks/modules/movie_details/screens/movie_details.screens.dart';
import 'package:movies_clicks/modules/onboarding/screens/onboarding.screens.dart';

import '../common_export.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return const HomepagePage();
      },
    ),
    GoRoute(
      path: '/moviedetails/:movie_id',
      name: "MovieDeatails",
      builder: (BuildContext context, GoRouterState state) {
        int movie_id = int.parse(state.params['movie_id']!);
        final routeArgs = state.extra! as Map;
        Movie movie = routeArgs['movie'] as Movie;
        return MovieDetails(
          movie_id: movie_id,
          movie: movie,
        );
      },
    ),
  ],
);

/// routes for the app  Without go_router
// import 'package:movies_clicks/movies_clicks.dart';

// import 'package:flutter/material.dart';

// Route routes(RouteSettings settings) {
//   switch (settings.name) {
//     case '/':
//       return MaterialPageRoute(builder: (_) => const SplashScreen());
//     case '/home':
//       return MaterialPageRoute(builder: (_) => const HomeScreen());
//     case '/auth':
//       return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
//     default:
//       return MaterialPageRoute(builder: (_) => const SplashScreen());
//   }
// }
