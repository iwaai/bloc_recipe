import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/FoodType.dart';
import '../../recipe_info_screen/RecipeInfoScreen.dart';
import '../../recipe_info_screen/bloc/recipe_info_bloc.dart';

class ListItem extends StatefulWidget {
  final FoodType meal;
  const ListItem({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Listmealtate createState() => _Listmealtate();
}

class _Listmealtate extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => RecipeInfoBloc(),
              child: RecipeInfo(
                id: widget.meal.id,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey,
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(widget.meal.image),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.meal.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Ready in ${widget.meal.readyInMinutes} Min",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
