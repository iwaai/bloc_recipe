import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants/theme/AppThemeCubit.dart';
import 'screens/navigation/NavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Favorite');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return BlocProvider(
        create: (context) => AppthemeCubit()..init(),
        child: BlocBuilder<AppthemeCubit, bool>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: state ? ThemeData.light() : ThemeData.dark(),
              home: const NavBar(),
            );
          },
        ),
      );
    });
  }
}
