import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_bloc/constants/Constants.dart';
import '../../../models/FoodType.dart';
import '../../recipe_info_screen/RecipeInfoScreen.dart';
import '../../recipe_info_screen/bloc/recipe_info_bloc.dart';

class FoodTypeWidget extends StatelessWidget {
  final List<FoodType> items;

  const FoodTypeWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(width: 20),
            ...items.map((item) {
              return RecipeCardType(items: item);
            }).toList()
          ],
        ));
  }
}

class RecipeCardType extends StatefulWidget {
  const RecipeCardType({
    Key? key,
    required this.items,
  }) : super(key: key);

  final FoodType items;

  @override
  _RecipeCardTypeState createState() => _RecipeCardTypeState();
}

class _RecipeCardTypeState extends State<RecipeCardType> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => RecipeInfoBloc(),
                  child: RecipeInfo(
                    id: widget.items.id,
                  ),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: (int.tryParse(widget.items.id) ?? 0) % 2 == 0
                    ? kPrimaryColor
                    : kSecondaryColor,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-2, -2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                  ),
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.10),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      width: 200,
                      foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.items.image,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(9),
                    child: Text(
                      widget.items.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: headingTheme.copyWith(fontSize: 18),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      "Ready in ${widget.items.readyInMinutes} Min",
                      style: paraTheme.copyWith(
                        fontSize: 14,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
