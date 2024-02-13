import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> groceryItems = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    _loadItem();
    super.initState();
  }

  void _loadItem() async {
    try {
      final url = Uri.https(
          'flutter-firebase-286ed-default-rtdb.firebaseio.com',
          'shopping-list.json');
      List<GroceryItem> loadedItem = [];
      var response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          error = "Failed to fetch item. Please try again later.";
        });
      }

      // handling no data case
      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      Map<String, dynamic> listData = json.decode(response.body);
      for (final item in listData.entries) {
        Category category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        loadedItem.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        groceryItems = loadedItem;
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        error = "Something went wrong. Please try again later.";
      });
    }
  }

  void _addItem() async {
    var newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = groceryItems.indexOf(item);
    setState(() {
      groceryItems.remove(item);
    });

    final url = Uri.https('flutter-firebase-286ed-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    var response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text("No Item added yet."));

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(groceryItems[index].id),
            onDismissed: (direction) {
              _removeItem(groceryItems[index]);
            },
            child: ListTile(
              leading: Container(
                  height: 20,
                  width: 20,
                  decoration:
                      BoxDecoration(color: groceryItems[index].category.color)),
              title: Text(groceryItems[index].name),
              trailing: Text(groceryItems[index].quantity.toString()),
            ),
          );
        },
      );
    }

    if (error != null) {
      content = Center(child: Text(error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Groceries",
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
