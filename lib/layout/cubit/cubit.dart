
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(NewsAppInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<Widget> newScreen =const [
    SportsScreen(),
    BusinessScreen(),
    ScienceScreen(),
  ];
  List<String> newTitles = ['sports', "business", 'science'];
  int currentIndex = 0;
  void changeNavcurrentIndex(value) {
    currentIndex = value;
    emit(NewsAppchangeNavcurrentIndexState());
  }

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "business"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "science"),
  ];
  List<dynamic> business = [];
  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(Url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      "apiKey": "16af51dd545248bb851c6b1702a61453"
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(Url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      "apiKey": "16af51dd545248bb851c6b1702a61453"
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSportsErrorState(onError.toString()));
    });
  }

  List<dynamic> science = [];
  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(Url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      "apiKey": "16af51dd545248bb851c6b1702a61453"
    }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetScienceErrorState(onError.toString()));
    });
  }

  bool isDark = false;
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else
{      isDark = !isDark;
}  
  CasheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeThemeModeState());
    });
  }

  List<dynamic> searchResult = [];
  void getSearch({required String value}) {
    emit(NewsGetSearchLoadingState());
    searchResult = [];
    DioHelper.getData(Url: 'v2/everything', query: {
      'q': value.toString(),
      "apiKey": "16af51dd545248bb851c6b1702a61453"
    }).then((value) {
      searchResult = value.data['articles'];
      print(searchResult[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }
}
