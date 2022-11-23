import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen.dart';

import 'cubit/states.dart';


class Newlayout extends StatelessWidget {
  const Newlayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);

        return Scaffold(
         appBar: AppBar(
            title: Text(cubit.newTitles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.changeThemeMode();
                  },
                  icon: Icon(cubit.isDark
                      ? Icons.brightness_4_rounded
                      : Icons.dark_mode))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeNavcurrentIndex(value);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems),
          body: cubit.newScreen[cubit.currentIndex],
        );
      },
    );
  }
}
