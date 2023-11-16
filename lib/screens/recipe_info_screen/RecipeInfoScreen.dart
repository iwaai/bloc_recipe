import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/LoadingWidget.dart';
import 'bloc/recipe_info_bloc.dart';
import './widgets/RecipeInfoWidget.dart';

class RecipeInfo extends StatefulWidget {
  final String id;
  const RecipeInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  late final RecipeInfoBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RecipeInfoBloc>(context);
    bloc.add(LoadRecipeInfo(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
          builder: (context, state) {
            if (state is RecipeInfoLoadState) {
              return const Center(child: LoadingWidget());
            } else if (state is RecipeInfoSuccesState) {
              return RacipeInfoWidget(
                info: state.recipe,
                nutrient: state.nutrient,
                similarlist: state.similar,
                // equipment: state.equipment,
              );
            } else if (state is RecipeInfoErrorState) {
              return const Center(
                child: Text("Error Occured"),
              );
            } else {
              return const Center(
                child: Text("Owo we glitched"),
              );
            }
          },
        ),
      ),
    );
  }
}
