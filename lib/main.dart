import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/app_routes.dart';

// Cubits
import 'blocs/auth_cubit.dart';
import 'blocs/cart_cubit.dart';
import 'blocs/product_cubit.dart';
import 'blocs/favorite_cubit.dart';
import 'blocs/order_history_cubit.dart';
import 'blocs/theme_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => ProductCubit()..loadProducts()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => OrderHistoryCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Guitar Store',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppRoutes.mainNavigation,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

