import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favourite_screen/FavouriteScreen.dart';
import '../home_screen/HomeScreen.dart';
import '../home_screen/bloc/home_recipes_bloc.dart';
import '../search_screen/SearchScreen.dart';
import '../search_screen/cubit/seach_page_cubit.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => HomeRecipesBloc(),
      child: const HomeScreen(),
    ),
    const FavoriteScreen(),
    BlocProvider(
      create: (context) => SearchPageCubit(),
      child: const SearchPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_max_outlined), label: 'home'),
          NavigationDestination(
              icon: Icon(Icons.favorite), label: 'favourites'),
          NavigationDestination(icon: Icon(Icons.search), label: 'search')
        ],
      ),
    );
  }
}
