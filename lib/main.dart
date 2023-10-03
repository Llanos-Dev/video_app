import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/presentation/provider/discover_provider.dart';
import 'package:video_app/presentation/screens/discover/discover_screen.dart';

import 'config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DiscoverProvider()..loadNextPage(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'VidepApp',
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}
