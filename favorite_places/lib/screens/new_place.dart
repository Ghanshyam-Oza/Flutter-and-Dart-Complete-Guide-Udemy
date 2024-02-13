import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/provider/favorite_place_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    void addPlace() {
      if (titleController.text.trim().isEmpty || selectedImage == null) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Invalid Place."),
                content: const Text("Please enter valid Place."),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
                ],
              );
            });
        return;
      }
      ref.read(favoritePlaceProvider.notifier).addFavoritePlace(
            FavoritePlace(
              name: titleController.text.trim(),
              image: selectedImage!,
            ),
          );
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 16,
          ),
          child: Column(
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              LocationInput(),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: addPlace,
                icon: const Icon(Icons.add),
                label: const Text("Add Place"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
