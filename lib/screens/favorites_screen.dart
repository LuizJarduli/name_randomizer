import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';
import 'package:name_randomizer/my_app_state.dart';
import 'package:name_randomizer/widgets/empty_list.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final favorites = appState.favorites;
    final hasFavorites = favorites.length > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: hasFavorites
          ? _FavoritesList(favorites: favorites, appState: appState)
          : const EmptyList(),
    );
  }
}

class _FavoritesList extends StatelessWidget {
  const _FavoritesList({
    required this.favorites,
    required this.appState,
  });

  final Set<WordPair> favorites;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      reverse: true,
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final pair = favorites.elementAt(index);
        final effectivePairSemanticsLabel = '${pair.first} ${pair.second}';

        return ListTile(
          title: Text(
            pair.asLowerCase,
            semanticsLabel: effectivePairSemanticsLabel,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              appState.removeFavorite(pair);
            },
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
