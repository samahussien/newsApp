import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/new_componants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("search"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormFeild(
                    context: context,
                      controller: searchController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      // onChange: (value) {
                      //   // searchController = Value;
                      //   cubit.getSearch(value: value);
                      // },
                      onSubmit: (value) {
                        cubit.getSearch(value: value);
                      },
                      label: "search",
                      prefix: Icons.search,
                      type: TextInputType.text),
                ),
                Expanded(
                    child: screenBuilder(
                        state: state,
                        dataList: cubit.searchResult,
                        isSearch: true))
              ],
            ),
          ),
        );
      },
    );
  }
}
