import 'package:edu_pagination/page/riverpod/pagination_handler_demo_page.dart';
import 'package:edu_pagination/page/riverpod/pagination_list_view_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ThemeModeDemoApp(),
    ),
  );
}

class ThemeModeDemoApp extends ConsumerWidget {
  const ThemeModeDemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: PaginationHandlerDemo(),
    );
  }
}
