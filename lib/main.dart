

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool? isDark = CasheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({required this.isDark, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusinessData()
        ..getScienceData()
        ..getSportsData()
        ..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                appBarTheme: const AppBarTheme(
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.pink,
                        statusBarIconBrightness: Brightness.light)),
                dividerTheme: const DividerThemeData(
                    indent: 20, endIndent: 20, color: Colors.white),
                scaffoldBackgroundColor: Colors.black,
                primarySwatch: Colors.pink,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.black,
                    unselectedItemColor: Colors.white,
                    selectedItemColor: Colors.pink,
                    type: BottomNavigationBarType.fixed)),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                dividerTheme: const DividerThemeData(
                    indent: 20, endIndent: 20, color: Colors.deepOrange),
                // primaryColor: Colors.deepOrange,
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    titleSpacing: 20,
                    iconTheme: IconThemeData(color: Colors.deepOrange),
                    actionsIconTheme: IconThemeData(
                      color: Colors.deepOrange,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark))),
            home: const Newlayout(),
          );
        },
      ),
    );
  }
}
