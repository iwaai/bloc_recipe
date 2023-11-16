import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app_bloc/constants/Constants.dart';
import '../../../models/Recipe.dart';

class FavoriteButton extends StatelessWidget {
  final Recipe info;
  const FavoriteButton({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ValueListenableBuilder<Box>(
        valueListenable: Hive.box("Favorite").listenable(),
        builder: (context, box, child) {
          bool isfavorite = box.containsKey(info.id);
          if (isfavorite) {
            return FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                final box = Hive.box("Favorite");
                box.delete(info.id);
              },
              child: const Icon(
                Icons.favorite,
              ),
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                final box = Hive.box("Favorite");
                box.put(info.id, info.toJson());
              },
              child: const Icon(
                Icons.favorite,
              ),
            );
          }
        },
      ),
    );
  }
}
