import 'package:flutter/material.dart';
class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the app bar (e.g., clear query or submit search)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Perform search based on the 'query' value
          // You can replace this with your search logic
          print('Searching for: $query');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the search results based on the 'query' value
    // You can replace this with your search results UI
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions that appear as the user types
    // You can replace this with your own suggestion logic
    final List<String> suggestions = query.isEmpty
        ? []
        : ['Result 1', 'Result 2', 'Result 3']
        .where((result) => result.contains(query))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            // You can perform an action when a suggestion is tapped
          },
        );
      },
    );
  }
}
