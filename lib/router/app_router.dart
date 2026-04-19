import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/sales/sales_screen.dart';
import '../screens/sales/new_sale_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/products/add_product_screen.dart';
import '../screens/customers/customers_screen.dart';
import '../screens/expenses/expenses_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/',
        redirect: _handleRedirect,
        routes: [
          // Splash
          GoRoute(
            path: '/',
            name: 'splash',
            builder: (context, state) => const SplashScreen(),
          ),
          
          // Onboarding
          GoRoute(
            path: '/onboarding',
            name: 'onboarding',
            builder: (context, state) => const OnboardingScreen(),
          ),
          
          // Auth
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            builder: (context, state) => const RegisterScreen(),
          ),
          
          // Main App Shell
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => MainShell(child: child),
            routes: [
              // Dashboard
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
              
              // Sales
              GoRoute(
                path: '/sales',
                name: 'sales',
                builder: (context, state) => const SalesScreen(),
              ),
              GoRoute(
                path: '/sales/new',
                name: 'newSale',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const NewSaleScreen(),
              ),
              
              // Products
              GoRoute(
                path: '/products',
                name: 'products',
                builder: (context, state) => const ProductsScreen(),
              ),
              GoRoute(
                path: '/products/add',
                name: 'addProduct',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AddProductScreen(),
              ),
              
              // Customers
              GoRoute(
                path: '/customers',
                name: 'customers',
                builder: (context, state) => const CustomersScreen(),
              ),
              
              // Expenses
              GoRoute(
                path: '/expenses',
                name: 'expenses',
                builder: (context, state) => const ExpensesScreen(),
              ),
              
              // Reports
              GoRoute(
                path: '/reports',
                name: 'reports',
                builder: (context, state) => const ReportsScreen(),
              ),
              
              // Settings
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      );

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final location = state.uri.path;

    // Don't redirect if still loading
    if (authState.status == AuthStatus.loading || 
        authState.status == AuthStatus.initial) {
      return location == '/' ? null : '/';
    }

    final isAuthenticated = authState.status == AuthStatus.authenticated;
    final isOnboardingComplete = authState.isOnboardingComplete ?? false;

    // Public routes
    final isPublicRoute = [
      '/',
      '/onboarding',
      '/login',
      '/register',
    ].contains(location);

    // If not authenticated
    if (!isAuthenticated) {
      if (isPublicRoute) {
        // If on splash and not onboarded, go to onboarding
        if (location == '/' && !isOnboardingComplete) {
          return '/onboarding';
        }
        return null; // Allow public routes
      }
      return isOnboardingComplete ? '/login' : '/onboarding';
    }

    // If authenticated
    if (isPublicRoute) {
      return '/dashboard'; // Redirect to dashboard
    }

    return null; // Allow access to protected routes
  }
}

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.point_of_sale_outlined),
            selectedIcon: Icon(Icons.point_of_sale),
            label: 'Sales',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Customers',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    switch (location) {
      case '/dashboard':
        return 0;
      case '/sales':
        return 1;
      case '/products':
        return 2;
      case '/customers':
        return 3;
      case '/expenses':
      case '/reports':
      case '/settings':
        return 4;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/sales');
        break;
      case 2:
        context.go('/products');
        break;
      case 3:
        context.go('/customers');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }
}
