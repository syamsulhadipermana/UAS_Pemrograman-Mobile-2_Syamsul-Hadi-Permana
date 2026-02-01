import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/favorite_cubit.dart';
import '../blocs/order_history_cubit.dart';
import '../models/order_model.dart';
import '../core/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          final isAuthenticated = authState is AuthAuthenticated;

          if (!isAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 80,
                    color: Colors.white54,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Not Logged In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please login to view your profile",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Go to Login"),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 👤 Profile Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white24,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        authState.role == 'admin' ? 'Administrator' : 'Guitar Enthusiast',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authState.email,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: authState.role == 'admin' ? Colors.orange : Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          authState.role == 'admin' ? '👑 Admin Account' : '✓ Verified Member',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 📊 Stats Section
                Row(
                  key: const ValueKey('profile-stats-row'),
                  children: [
                    Expanded(
                      child: BlocBuilder<OrderHistoryCubit, List<Order>>(
                        builder: (context, orders) {
                          return _StatBox(
                            icon: Icons.shopping_bag,
                            title: "Orders",
                            value: orders.length.toString(),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<FavoriteCubit, List<int>>(
                        builder: (context, favorites) {
                          return _StatBox(
                            icon: Icons.favorite,
                            title: "Favorites",
                            value: favorites.length.toString(),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: _StatBox(
                        icon: Icons.star,
                        title: "Rating",
                        value: "4.8",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ⚙️ Menu Items
                _MenuItem(
                  icon: Icons.edit,
                  title: "Edit Profile",
                  subtitle: "Update your information",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Edit profile feature coming soon! 📝"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.history,
                  title: "Order History",
                  subtitle: "View past orders & receipts",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.orderHistory);
                  },
                ),
                _MenuItem(
                  icon: Icons.location_on,
                  title: "Addresses",
                  subtitle: "Manage delivery addresses",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Address management coming soon! 📍"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.payment,
                  title: "Payment Methods",
                  subtitle: "Add or remove payment options",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Payment settings coming soon! 💳"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  subtitle: "Manage notification settings",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Notification settings coming soon! 🔔"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
                _MenuItem(
                  icon: Icons.settings,
                  title: "Settings",
                  subtitle: "App preferences & theme",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "Contact customer service",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Contact support feature coming soon! 🆘"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // 🚪 Logout Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF111111),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Are you sure want to logout?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.login,
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // App Info
                Text(
                  "Guitar Store v1.0.0",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: Colors.white, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
