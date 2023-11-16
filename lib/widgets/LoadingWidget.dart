import 'package:flutter/material.dart';
import 'package:recipe_app_bloc/constants/Constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        color: kPrimaryColor,
        strokeWidth: 1.5,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
