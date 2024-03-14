import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filter_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _selectedIndex = 0;

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onChangeScreenViaDrawer(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.push<Map<Filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);

    String title = 'Categories';
    Widget content = Categories(
      availableMeals: availableMeals,
    );
    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      content = MealsScreen(
        meals: favoriteMeals,
      );
      title = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
      drawer: MainDrawer(
        onChangePage: _onChangeScreenViaDrawer,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _changePage(index);
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
