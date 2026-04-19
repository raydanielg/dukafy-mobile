import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../screens/landing_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/business_setup_screen.dart';
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
        debugLogDiagnostics: true,
        errorBuilder: (context, state) => ErrorScreen(error: state.error),
        routes: [
          // Landing (First screen)
          GoRoute(
            path: '/',
            name: 'landing',
            builder: (context, state) => const SimpleLandingScreen(),
          ),

          // Splash (alternative entry)
          GoRoute(
            path: '/splash',
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
          GoRoute(
            path: '/business-setup',
            name: 'business-setup',
            builder: (context, state) => BusinessSetupScreen(
              registrationData: state.extra as Map<String, dynamic>?,
            ),
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
              
              // Products
              GoRoute(
                path: '/products',
                name: 'products',
                builder: (context, state) => const ProductsScreen(),
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
          
          // New Sale (outside shell - full screen)
          GoRoute(
            path: '/sales/new',
            name: 'newSale',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const NewSaleScreen(),
          ),
          
          // Add Product (outside shell - full screen)
          GoRoute(
            path: '/products/add',
            name: 'addProduct',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const AddProductScreen(),
          ),
        ],
      );

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final location = state.uri.path;

    // Allow landing and splash to always show
    if (location == '/' || location == '/splash') {
      return null;
    }

    // Don't redirect if still loading (except splash)
    if (authState.status == AuthStatus.loading || 
        authState.status == AuthStatus.initial) {
      return null;
    }

    final isAuthenticated = authState.status == AuthStatus.authenticated;
    final isOnboardingComplete = authState.isOnboardingComplete ?? false;

    // Public routes
    final isPublicRoute = [
      '/',
      '/splash',
      '/onboarding',
      '/business-setup',
      '/login',
      '/register',
    ].contains(location);

    // If not authenticated
    if (!isAuthenticated) {
      if (isPublicRoute) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/sales/new'),
        backgroundColor: const Color(0xFF00C853),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => _onItemTapped(0, context),
              ),
              _buildNavItem(
                icon: Icons.point_of_sale_outlined,
                selectedIcon: Icons.point_of_sale,
                label: 'Sales',
                isSelected: selectedIndex == 1,
                onTap: () => _onItemTapped(1, context),
              ),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(
                icon: Icons.inventory_2_outlined,
                selectedIcon: Icons.inventory_2,
                label: 'Stock',
                isSelected: selectedIndex == 2,
                onTap: () => _onItemTapped(2, context),
              ),
              _buildNavItem(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: 'More',
                isSelected: selectedIndex == 4,
                onTap: () => _onItemTapped(4, context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00C853).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? const Color(0xFF00C853) : Colors.white54,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF00C853) : Colors.white54,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
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

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Navigation Error',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error',
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
