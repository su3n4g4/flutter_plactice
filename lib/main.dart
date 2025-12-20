import 'package:flutter/material.dart';
import 'features/item/item_list_page.dart';
import 'features/item/in_memory_item_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = InMemoryItemRepository();

    final router = GoRouter(
      initialLocation: '/items',
      routes: [
        GoRoute(
          path: '/items',
          builder: (context, state) => ItemListPage(repository: repository),
        ),
        GoRoute(
          path: '/items/new',
          builder: (context, state) => const ItemEditPage(repository: repository),
        ),
        GoRoute(
          path: '/items/:id/edit',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ItemEditPage(
              repository: repository,
              itemId: id,
            );
          },
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Item App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
