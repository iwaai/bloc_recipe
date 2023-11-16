import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/theme/AppThemeCubit.dart';
import './bloc/home_recipes_bloc.dart';
import '../../widgets/LoadingWidget.dart';
import '../../models/FoodType.dart';

import './widgets/FoodTypeWidget.dart';
import './widgets/ListItem.dart';
import '../../constants/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeRecipesBloc bloc;
  void initState() {
    bloc = BlocProvider.of<HomeRecipesBloc>(context);
    bloc.add(LoadHomeRecipe());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "CoCoEats",
            style: headingTheme.copyWith(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          actions: [
            BlocBuilder<AppthemeCubit, bool>(
              builder: (context, state) {
                return IconButton(
                    icon: state
                        ? const Icon(
                            Icons.lightbulb,
                            color: Colors.black,
                          )
                        : const Icon(Icons.lightbulb),
                    onPressed: () {
                      context.read<AppthemeCubit>().init();
                    });
              },
            )
          ],
        ),
        body: BlocBuilder<HomeRecipesBloc, HomeRecipesState>(
          builder: (context, state) {
            if (state is HomeRecipesLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is HomeRecipesSuccess) {
              return HomeScreenWidget(
                breakfast: state.breakfast,
                cake: state.cake,
                drinks: state.drinks,
                burgers: state.burgers,
                lunch: state.lunch,
                pizza: state.pizza,
                rice: state.rice,
              );
            } else if (state is HomeRecipesError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: Text("Noting happingng"),
              );
            }
          },
        ),
      ),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  final List<FoodType> breakfast;
  final List<FoodType> lunch;
  final List<FoodType> drinks;
  final List<FoodType> burgers;
  final List<FoodType> pizza;
  final List<FoodType> cake;
  final List<FoodType> rice;
  HomeScreenWidget({
    required this.breakfast,
    required this.lunch,
    required this.drinks,
    required this.burgers,
    required this.pizza,
    required this.cake,
    required this.rice,
  });

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "What would you \nlike 2 Cook?",
              style: paraTheme.copyWith(
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: header("Find Popular Breakfast Recipes", "breakfast"),
          ),
          const SizedBox(height: 10),
          FoodTypeWidget(
            items: widget.breakfast,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: header("Make Popular Drinks", "drinks"),
          ),
          const SizedBox(height: 10),
          FoodTypeWidget(items: widget.drinks),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: header("The Best pizza", "Pizza"),
          ),
          const SizedBox(height: 10),
          FoodTypeWidget(items: widget.pizza),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Best Lunch Recipes", "lunch"),
                ...widget.lunch.map((meal) {
                  return ListItem(
                    meal: meal,
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  header(String name, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_forward_sharp))
        ],
      ),
    );
  }
}
