import 'package:bloc/bloc.dart';
import '../../../models/Failure.dart';
import '../../../models/Recipe.dart';
import '../../../models/SimilarList.dart';
import '../../../models/Nutrient.dart';
import '../../../repo/Get_recipe_info.dart';
part 'recipe_info_event.dart';
part 'recipe_info_state.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  final GetRecipeInfo repo = GetRecipeInfo();

  RecipeInfoBloc() : super(RecipeInfoInitial()) {
    on<RecipeInfoEvent>((event, emit) async {
      if (event is LoadRecipeInfo) {
        try {
          emit(RecipeInfoLoadState());
          final data = await repo.getRecipeInfo(event.id);
          emit(
            RecipeInfoSuccesState(
              recipe: data[0],
              nutrient: data[3],
              similar: data[1].list,
            ),
          );
        } on Failure catch (e) {
          emit(FailureState(error: e));
        } catch (e) {
          print(e);
          emit(RecipeInfoErrorState());
        }
      }
    });
  }
}
