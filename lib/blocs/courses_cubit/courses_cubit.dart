import 'package:elmoktaser_elshamel/models/categories_model.dart';
import 'package:elmoktaser_elshamel/models/course_attachment_model.dart';
import 'package:elmoktaser_elshamel/models/course_content_model.dart';
import 'package:elmoktaser_elshamel/models/courses_model.dart';
import 'package:elmoktaser_elshamel/repos/courses_repo.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());
  static CoursesCubit get(context) => BlocProvider.of(context);
//========================pagination===============
  int page = 1;

  CategoriesModel? categoriesModel;

  List<CategoryItem> categoriesList = [];
  TabController? tabController;
  List<String> tabs = ['All'.tr()];
  Future<void> getCourseCategories(
    context,
  ) async {
    categoriesList = [];
    emit(GetCategoriesLoadingState());
    try {
      var res = await CoursesRepositories.getCourseCategories(context);

      categoriesModel = CategoriesModel.fromJson(res);
      categoriesList = categoriesModel?.data ?? [];
      tabs = ['All'.tr()];
      for (var item in categoriesList) {
        tabs.add(item.title!);
      }

      emit(GetCategoriesLoadedState());
    } catch (error) {
      emit(GetCategoriesErrorState());
    }
  }

//===================get Searched Course================
  final homeSearchController = TextEditingController();
  final coursesSearchController = TextEditingController();
  CoursesModel? searchedCoursesModel;
  List<CoursesItem> searchedCoursesList = [];
  Future<void> getSearchedCourse(String courseName, context) async {
    emit(GetSearchedCourseLoadingState());
    searchedCoursesList = [];
    try {
      var res = await CoursesRepositories.getSearchedCourses(courseName);

      if (res['status'] < 300) {
        searchedCoursesModel = CoursesModel.fromJson(res);
        searchedCoursesList = searchedCoursesModel?.data ?? [];
        emit(GetSearchedCourseLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']['search'][0]);
        emit(GetSearchedCourseErrorState());
      }
    } catch (error) {
      emit(GetSearchedCourseErrorState());
    }
  }

  void changeSearchState() {
    emit(ChangeSearchState());
  }

//===============all courses======================
  List<Questions> queAndAnsList = [];
  CoursesModel? coursesModel;
  List<CoursesItem> coursesList = [];
  Future<void> getAllCourses({page = 1}) async {
    if (page == 1) {
      coursesList = [];
      queAndAnsList = [];
      emit(GetAllCoursesLoadingState());
    } else {
      emit(LoadingPaginationCoursesState());
    }

    try {
      var res = await CoursesRepositories.getAllCourses(page);
      coursesModel = CoursesModel.fromJson(res);
      if (page == 1) {
        coursesList = [];
        queAndAnsList = [];
      }
      coursesList.addAll(coursesModel?.data ?? []);
      queAndAnsList = [];
      for (var item in coursesList) {
        queAndAnsList.addAll(item.questions!);
      }
      emit(GetAllCoursesLoadedState());
    } catch (error) {
      emit(GetAllCoursesErrorState());
    }
  }

  CoursesModel? categoryCoursesModel;
  List<CoursesItem> categoryCoursesList = [];
  List<int> pages = [];
  Future<void> getCoursesByCategory(categoryId, context, {page = 1}) async {
    if (page == 1) {
      emit(GetAllCoursesLoadingState());
    } else {
      emit(LoadingPaginationCoursesState());
    }
    try {
      var res = await CoursesRepositories.getCoursesByCategory(
          categoryId, context, page);

      categoryCoursesModel = CoursesModel.fromJson(res);
      categoryCoursesList.addAll(categoryCoursesModel?.data ?? []);

      emit(GetAllCoursesLoadedState());
    } catch (error) {
      emit(GetAllCoursesErrorState());
    }
  }

//=================course content==============================
  CourseContentModel? coursesContentModel;
  List<CourseContentSection> coursesContentList = [];
  Future<void> getCoursesContent(courseId) async {
    emit(GetCourseContentLoadingState());
    try {
      var res = await CoursesRepositories.getCoursesContent(courseId);

      coursesContentModel = CourseContentModel.fromJson(res);
      coursesContentList = coursesContentModel?.data ?? [];

      emit(GetCourseContentLoadedState());
    } catch (error) {
      emit(GetCourseContentErrorState());
    }
  }

//=====================course details =======================
  TabController? detailsTabController;
  List<String> courseDetailsTabList = [
    'Description'.tr(),
    'Course_Content'.tr(),
    'Course_Questions'.tr(),
    'course_bag'.tr(),
    'Ratings'.tr(),
  ];

  //====================personal cousers data===============
  TabController? personalTabController;

//========================personal couse detail screen======================

  int sectionIndex = 0;

  TabController? personalDetailsTabController;
  List<String> personalDetailsCoursesTabList = [
    'lessons'.tr(),
    'tables'.tr(),
    'course_bag'.tr(),
    'attachments'.tr(),
    'Ratings'.tr()
  ];
  //====================course Content=====================
  int? currentIndex = 0;

  void changeColorOnTab(index, newSectionIndex) {
    currentIndex = index;
    sectionIndex = newSectionIndex;

    emit(ChangeExpandedState());
  }

  void tabIndexChanged() {
    emit(ChangeExpandedState());
  }

//============================Subscribed Courses====================

  CoursesModel? subscribedCoursesModel;
  List<CoursesItem> subscribedCoursesList = [];
  List<CoursesItem> inProgressCoursesList = [];
  List<CoursesItem> finishedCoursesList = [];

  Future<void> getSubscribedCourses(context) async {
    subscribedCoursesList = [];
    inProgressCoursesList = [];
    finishedCoursesList = [];
    emit(GetSubscribedCourseLoadingState());
    try {
      var res = await CoursesRepositories.getSubscribedCourses();
      if (res['status'] < 300) {
        inProgressCoursesList = [];
        finishedCoursesList = [];
        subscribedCoursesModel = CoursesModel.fromJson(res);
        subscribedCoursesList = subscribedCoursesModel?.data ?? [];

        for (var item in subscribedCoursesList) {
          if (item.progress < 100) {
            inProgressCoursesList.add(item);
          } else {
            finishedCoursesList.add(item);
          }
        }
        emit(GetSubscribedCourseLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        emit(GetSubscribedCourseErrorState());
      }
    } catch (error) {
      emit(GetSubscribedCourseErrorState());
    }
  }

  CoursesItem? singleCourse;
  String? singleCourseErrorMsg;
  Future<void> getCourseById(courseId, context) async {
    singleCourseErrorMsg = null;
    emit(GetSingleCourseLoadingState());
    try {
      var res = await CoursesRepositories.getCourseById(courseId);

      if (res['status'] < 300) {
        singleCourse = CoursesItem.fromJson(res['data']);
        emit(GetSingleCourseLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        singleCourseErrorMsg = res['data'];
        emit(GetSingleCourseErrorState());
      }
    } catch (error) {
      emit(GetSingleCourseErrorState());
    }
  }

  CourseContentModel? singleCourseContentmodel;
  List<CourseContentSection>? singleCourseContentItem = [];
  Future<void> getCourseContentById(courseId) async {
    singleCourseContentItem = [];
    emit(GetCourseContentLoadingState());
    try {
      var res = await CoursesRepositories.getCourseContentById(courseId);
      singleCourseContentmodel = CourseContentModel.fromJson(res);
      if (res['data'] != null) {
        singleCourseContentItem = singleCourseContentmodel?.data ?? [];
      } else {
        AppUtil.flushbarNotification(res['data']);
      }

      emit(GetCourseContentLoadedState());
    } catch (error) {
      emit(GetCourseContentErrorState());
    }
  }

  Future<void> addCourseToProgress(context, courseId) async {
    emit(AddCourseToProgressLoadingState());
    try {
      var res = await CoursesRepositories.addCourseToProgress(courseId);
      if (res['data'] == null) {
        AppUtil.flushbarNotification(res['status']);
      }

      emit(AddCourseToProgressLoadedState());
    } catch (error) {
      emit(AddCourseToProgressErrorState());
    }
  }

  bool? isTableViewed = false;
  void changeIsTableViewed() {
    isTableViewed = !isTableViewed!;
    emit(ChangeIsViewedState());
  }

  //==============course attachment===================
  List<AttachmentItem> courseAttachmentItems = [];
  Future<void> getCoursesAttachment(courseId, context) async {
    courseAttachmentItems = [];
    emit(GetCourseAttachmentLoadingState());
    try {
      var res = await CoursesRepositories.getCoursesAttachment(courseId);
      if (res['status'] < 300) {
        CourseAttachmentModel courseAttachmentModel =
            CourseAttachmentModel.fromJson(res);
        courseAttachmentItems.addAll(courseAttachmentModel.data!);
        emit(GetCourseAttachmentLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        emit(GetCourseAttachmentLoadedState());
      }
    } catch (error) {
      emit(GetCourseAttachmentLoadedState());
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

//====================check course exit in subscrib=====================
  int? active;
  Future<void> checkCourseExitInSubscribe(courseId, context) async {
    active = null;
    emit(CheckCourseSubscribtionLoadingState());
    try {
      var res = await CoursesRepositories.checkCourseExitInSubscirb(courseId);
      if (res['status'] < 300) {
        if (res['data'].length != 0) {
          if (res['data']['active'] != null) {
            active = int.parse(res['data']['active'].toString());
          }
        }
        emit(CheckCourseSubscribtionLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);
        emit(CheckCourseSubscribtionErrorState());
      }
    } catch (error) {
      emit(CheckCourseSubscribtionErrorState());
    }
  }

//======================ratings=====================
  TextEditingController commentTextEditingController = TextEditingController();
  double rate = 0;
  Future<void> addRate(courseId) async {
    emit(AddRateLoadingState());
    try {
      var res = await CoursesRepositories.addRateToCourse(courseId,
          {"comment": commentTextEditingController.text, "rating": rate});
      getCourseContentById(courseId);
      if (res['status'] < 300) {
        AppUtil.flushbarNotification(res['data']);
        emit(AddRateLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);

        emit(AddRateErrorState());
      }
    } catch (error) {
      emit(AddRateErrorState());
    }
  }

  Future<void> updateRate(rateId, courseId) async {
    emit(UpdateRateLoadingState());
    try {
      var res = await CoursesRepositories.updateRateingToCourse(rateId, {
        "comment": commentTextEditingController.text,
        "rating": rate,
        "_method": "PUT"
      });
      if (res['status'] < 300) {
        getCourseContentById(courseId);

        AppUtil.flushbarNotification(res['data']);

        emit(UpdateRateLoadedState());
      } else {
        AppUtil.flushbarNotification(res['data']);

        emit(UpdateRateErrorState());
      }
    } catch (error) {
      emit(UpdateRateErrorState());
    }
  }
}
