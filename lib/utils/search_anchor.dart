import 'package:flutter/material.dart';

class CustomSearchDelegate<T> extends SearchDelegate<T?> {
  final List<T> items;
  final String Function(T) getTitle;
  final ValueChanged<T> onSelect;

  CustomSearchDelegate({
    required this.items,
    required this.getTitle,
    required this.onSelect,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ""; // Clear search text
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Now valid because T? is allowed
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white, // TextField background always white
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge:
            TextStyle(color: Colors.black), // Ensure text remains visible
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Not needed for our use case
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    final filteredItems = items
        .where((item) =>
            getTitle(item).toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(getTitle(item)),
            onTap: () {
              onSelect(item);
              close(context, item);
            },
          );
        },
      ),
    );
  }
}
