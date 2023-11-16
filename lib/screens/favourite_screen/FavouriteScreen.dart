import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../constants/Constants.dart';
import '../../models/FoodType.dart';
import '../../models/Recipe.dart';
import '../../screens/home_screen/widgets/ListItem.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
        ),
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('Favorite').listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.heart_fill,
                        size: 105,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "You don't have any Favorite recipe yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemBuilder: (context, i) {
                    final info = box.getAt(i);
                    final data = Recipe.fromJson(info);

                    return ListItem(
                      meal: FoodType(
                        id: data.id.toString(),
                        image: data.image!,
                        name: data.title!,
                        readyInMinutes: data.readyInMinutes.toString(),
                        servings: data.servings.toString(),
                      ),
                    );
                  },
                  itemCount: box.length);
            }),
      ),
    );
  }
}
