import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/cart_cubit.dart';
import '../models/cart_item_model.dart';
import 'home_page.dart';
import 'catalog_page.dart';
import 'cart_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'admin_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        // Build pages based on auth state
        List<Widget> pages;
        List<BottomNavigationBarItem> navItems;

        // Debug: Print current auth state
        if (authState is AuthAuthenticated) {
          debugPrint('🔐 MainNavigation - User logged in as: ${authState.role}');
        }

        if (authState is! AuthAuthenticated) {
          // User belum login
          pages = const [
            HomePage(),
            CatalogPage(),
            CartPage(),
            LoginPage(),
          ];
          navItems = [
            const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
            const BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Collections"),
            BottomNavigationBarItem(icon: _buildCartBadge(context), label: "Cart"),
            const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Login"),
          ];
        } else if (authState.role == 'admin') {
          // Admin view
          pages = const [
            AdminPage(),
            ProfilePage(),
          ];
          navItems = const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ];
        } else {
          // User logged in
          pages = const [
            HomePage(),
            CatalogPage(),
            CartPage(),
            ProfilePage(),
          ];
          navItems = [
            const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
            const BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Collections"),
            BottomNavigationBarItem(icon: _buildCartBadge(context), label: "Cart"),
            const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
          ];
        }

        // Reset index if out of range
        if (_currentIndex >= pages.length) {
          _currentIndex = 0;
        }

        return Scaffold(
          extendBody: true,
          body: pages[_currentIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFF111111),
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white38,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                elevation: 0,
                items: navItems,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartBadge(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartItem>>(
      builder: (context, cartItems) {
        final itemCount = cartItems.length;
        return Stack(
          children: [
            const Icon(Icons.shopping_bag_rounded),
            if (itemCount > 0)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

