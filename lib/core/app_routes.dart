import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/main_navigation.dart';
import '../pages/detail_page.dart';
import '../pages/cart_page.dart';
import '../pages/admin_page.dart';
import '../pages/about_page.dart';
import '../pages/favorites_page.dart';
import '../pages/profile_page.dart';
import '../pages/catalog_page.dart';
import '../pages/checkout_page.dart';
import '../pages/settings_page.dart';
import '../pages/order_history_page.dart';

class AppRoutes {
  static const mainNavigation = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const detail = '/detail';
  static const cart = '/cart';
  static const admin = '/admin';
  static const about = '/about';
  static const favorites = '/favorites';
  static const profile = '/profile';
  static const catalog = '/catalog';
  static const checkout = '/checkout';
  static const settings = '/settings';
  static const orderHistory = '/order_history';

  static Map<String, WidgetBuilder> routes = {
    mainNavigation: (context) => const MainNavigation(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomePage(),
    detail: (context) => const DetailPage(),
    cart: (context) => const CartPage(),
    admin: (context) => const AdminPage(),
    about: (context) => const AboutPage(),
    favorites: (context) => const FavoritesPage(),
    profile: (context) => const ProfilePage(),
    catalog: (context) => const CatalogPage(),
    checkout: (context) => const CheckoutPage(),
    settings: (context) => const SettingsPage(),
    orderHistory: (context) => const OrderHistoryPage(),
  };
}
