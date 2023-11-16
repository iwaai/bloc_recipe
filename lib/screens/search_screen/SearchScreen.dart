import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/SearchAutoComplete.dart';
import '../../widgets/LoadingWidget.dart';
import '../recipe_info_screen/RecipeInfoScreen.dart';
import '../recipe_info_screen/bloc/recipe_info_bloc.dart';
import 'cubit/seach_page_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
        builder: (context, state) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(12),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search Recipes..",
                        suffixIcon: IconButton(
                          icon:
                              const Icon(Icons.search, color: Colors.redAccent),
                          onPressed: () {},
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.black.withOpacity(.5),
                            ),
                            borderRadius: BorderRadius.circular(15))),
                    onChanged: (value) {
                      BlocProvider.of<SearchPageCubit>(context)
                          .textChange(value);
                    },
                    onSubmitted: (v) {},
                  ),
                ),
              ),
            ),
            body: SafeArea(
                child: (state.status == Status.success &&
                        state.searchList.isNotEmpty)
                    ? ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          ...state.searchList.map((list) {
                            return SearchAutoCompleteTile(list: list);
                          }).toList()
                        ],
                      )
                    : state.status == Status.loading
                        ? const Center(child: LoadingWidget())
                        : const Center(
                            child: Text(
                            'Find The best Recipes',
                          ))),
          ));
    });
  }
}

class SearchAutoCompleteTile extends StatefulWidget {
  final SearchAutoComplete list;
  const SearchAutoCompleteTile({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _SearchAutoCompleteTileState createState() => _SearchAutoCompleteTileState();
}

class _SearchAutoCompleteTileState extends State<SearchAutoCompleteTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(boxShadow: const [
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
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => RecipeInfoBloc(),
                      child: RecipeInfo(
                        id: widget.list.id,
                      ),
                    )));
          },
          leading: Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.list.image))),
          ),
          title: Text(
            widget.list.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
