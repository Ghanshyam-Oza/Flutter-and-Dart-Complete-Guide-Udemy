import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/provider/favorite_place_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaceListScreen extends ConsumerStatefulWidget {
  const FavoritePlaceListScreen({super.key});

  @override
  ConsumerState<FavoritePlaceListScreen> createState() =>
      _FavoritePlaceListScreenState();
}

class _FavoritePlaceListScreenState
    extends ConsumerState<FavoritePlaceListScreen> {
  late Future _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(favoritePlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    List<FavoritePlace> favoritePlace = ref.watch(favoritePlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshots) => snapshots.connectionState ==
                ConnectionState.waiting
            ? const CircularProgressIndicator()
            : favoritePlace.isEmpty
                ? Center(
                    child: Text(
                      "No Item Found",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  )
                : ListView.builder(
                    itemCount: favoritePlace.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceDetailScreen(
                                    title: favoritePlace[index].name,
                                    image: favoritePlace[index].image),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundImage:
                                  FileImage(favoritePlace[index].image),
                            ),
                            title: Text(
                              favoritePlace[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
