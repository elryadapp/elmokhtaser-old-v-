import 'package:elmoktaser_elshamel/blocs/layout_cubit/layout_cubit.dart';
import 'package:elmoktaser_elshamel/models/general_models/about_model.dart';
import 'package:elmoktaser_elshamel/models/general_models/news_model.dart';
import 'package:elmoktaser_elshamel/models/general_models/single_news_model.dart';
import 'package:elmoktaser_elshamel/models/general_models/team_model.dart';
import 'package:elmoktaser_elshamel/models/general_models/terms_model.dart';
import 'package:elmoktaser_elshamel/repos/general_repo.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  static ServicesCubit get(context) => BlocProvider.of(context);

  void changeLang(langCode, BuildContext context)async {
    if (langCode == 'ar') {
      context.setLocale(const Locale('ar'));
      Constants.lang = context.locale.toString();

    } else {
      context.setLocale(const Locale('en'));
      Constants.lang = context.locale.toString();

    }
          isLangExpanded=false;

     
   await CacheHelper.assignData(key: 'lang', value: Locale(langCode).toString());
   LayoutCubit.get(context).changeCurrentPageIndex(4);
  Navigator.pushNamedAndRemoveUntil(context,Routes.layout, ModalRoute.withName('/'));

    emit(LangChangeState());
  }

  bool? isLangExpanded = false;

  void changeLangExpanedState(val) {
    isLangExpanded = val;
    emit(ChangeLangExpandedState());
  }


//================================about data=========================================
  About? aboutModel;
  Teams? teamModel;
  List<TeamItem> teamsList = [];
  Future<void> getAboutData() async {
    emit(AboutLoadingState());
    try {
      var aboutRes = await GeneralRepositories.getAboutData();
      var teamRes = await GeneralRepositories.getTeamsData();
      aboutModel = About.fromJson(aboutRes);

      teamModel = Teams.fromJson(teamRes);
      if (teamModel!.data != null) {
        for (var team in teamModel!.data!) {
          teamsList.add(team);
        }
      }
      emit(AboutLoadedState());
    } catch (error) {
      emit(AboutErrorState());
    }
  }

//======================================termes data=============================================

  TermsAndCondition? termsAndConditionModel;

  List<TermesAndConditionData> termesList = [];
  Future<void> getTermesData() async {
    emit(TermesLoadingState());
    try {
      var res = await GeneralRepositories.getTermesData();

      termsAndConditionModel = TermsAndCondition.fromJson(res);
      termesList = termsAndConditionModel?.data ?? [];
      emit(TermesLoadedState());
    } catch (error) {
      emit(TermesErrorState());
    }
  }
//===================================privacy data============================

  TermsAndCondition? privacy;

  List<TermesAndConditionData> privacyList = [];
  Future<void> getPrivacyData() async {
    emit(TermesLoadingState());
    try {
      var res = await GeneralRepositories.getPrivacyData();

      privacy = TermsAndCondition.fromJson(res);
      privacyList = privacy?.data ?? [];
      emit(TermesLoadedState());
    } catch (error) {
      emit(TermesErrorState());
    }
  }

  //=========================news ==============================================

  News? newsModel;

  List<NewsItem> newsList = [];
  Future<void> getAllNewsData({page=1}) async {
    if(page==1){
      newsList = [];
    emit(NewsLoadingState());
    }
    else{
      emit(PaginationLoadingState());
    }
    try {
      var res = await GeneralRepositories.getAllNewsData(
        page: page
      );

      newsModel = News.fromJson(res);
      newsList.addAll( newsModel?.data ?? []);
      emit(NewsLoadedState());
    } catch (error) {
      emit(NewsErrorState());
    }
  }

  SingleNewsDetails? singleNewsModel;

  Future<void> getSingleNewsData(
    id,
  ) async {
    emit(NewsLoadingState());
    try {
      var res = await GeneralRepositories.getSingleNewsData(
        id,
      );

      singleNewsModel = SingleNewsDetails.fromJson(res);
      emit(NewsLoadedState());
    } catch (error) {
      emit(NewsErrorState());
    }
  }

  //===================pagination data===========================
  int page=1;
 
  
}
