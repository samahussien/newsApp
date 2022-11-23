
abstract class NewsAppStates {}

class NewsAppInitialState extends NewsAppStates {}

class NewsAppBottomNavBarState extends NewsAppStates {}

class NewsAppchangeNavcurrentIndexState extends NewsAppStates {}

class NewsGetBusinessSuccessState extends NewsAppStates {}

class NewsGetBusinessLoadingState extends NewsAppStates {}

class NewsGetBusinessErrorState extends NewsAppStates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsAppStates {}

class NewsGetSportsLoadingState extends NewsAppStates {}

class NewsGetSportsErrorState extends NewsAppStates {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState extends NewsAppStates {}

class NewsGetScienceLoadingState extends NewsAppStates {}

class NewsGetScienceErrorState extends NewsAppStates {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsChangeThemeModeState extends NewsAppStates {}

class NewsGetSearchSuccessState extends NewsAppStates {}

class NewsGetSearchLoadingState extends NewsAppStates {}

class NewsGetSearchErrorState extends NewsAppStates {
  final String error;
  NewsGetSearchErrorState(this.error);
}
