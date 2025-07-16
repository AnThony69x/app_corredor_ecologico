import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/observation/presentation/screens/observation_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    // final supabase = Supabase.instance.client;
    // final session = supabase.auth.currentSession;
    // final isLoggedIn = session != null;
    // final isLoggingIn = state.matchedLocation == '/login';
    // if (!isLoggedIn && !isLoggingIn) {
    //   return '/login';
    // }
    // if (isLoggedIn && isLoggingIn) {
    //   return '/home';
    // }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/observaciones',
      builder: (context, state) => const ObservationListScreen(participanteId: 'demo_participante'),
    ),
    GoRoute(
      path: '/',
      redirect: (context, state) => '/observaciones',
    ),
  ],
); 