import 'dart:async';
import 'dart:convert';

import 'package:elmoktaser_elshamel/models/attempts_model.dart';
import 'package:elmoktaser_elshamel/models/couse_exam.dart';
import 'package:elmoktaser_elshamel/models/general_exams_model.dart';
import 'package:elmoktaser_elshamel/models/more_options_model.dart';
import 'package:elmoktaser_elshamel/models/sudent_exam_result_model.dart';
import 'package:elmoktaser_elshamel/models/user_exam_model.dart';
import 'package:elmoktaser_elshamel/repos/contest_repo.dart';
import 'package:elmoktaser_elshamel/repos/test_repo.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
part 'tests_state.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit() : super(TestInitial());
  static TestsCubit get(context) => BlocProvider.of(context);

List<MQuestion>?userAnswers=[];
  //=================main test data========================
  TabController? testsTabController;
 int? selected;
  GeneralExamCategories? categoriesModel;
  List<String> testsTabTitlesList = [];

  List<GeneralExamItem> categoriesList = [];

  TabController? tabController;

  Future<void> getGeneralExamCategories() async {
    emit(GetGeneralExamCategoriesLoadingState());
    try {
      var res = await TestRepositories.getExamCategories();

      categoriesModel = GeneralExamCategories.fromJson(res);
      categoriesList = categoriesModel?.data ?? [];

      testsTabTitlesList = [];
      for (var item in categoriesList) {
        testsTabTitlesList.add(item.title!);
      }

      emit(GetGeneralExamCategoriesLoadedState());
    } catch (error) {
      emit(GetGeneralExamCategoriesErrorState());
    }
  }

  //================get user exams==============
  UserExamModel? userExamModel;
  List<UserExamItem> userExamsList = [];
  Future<void> getUserExams(context) async {
    userExamsList = [];
    emit(GetUserExamLoadingState());
    try {
      var res = await TestRepositories.getUserExam();
      if (res['status'] <= 300) {
        userExamModel = UserExamModel.fromJson(res);
        userExamsList = userExamModel?.data ?? [];
        emit(GetUserExamLoadedState());
      } else {
        AppUtil.flushbarNotification( res['data']);
        emit(GetUserExamErrorState());
      }
    } catch (error) {
      emit(GetUserExamErrorState());
    }
  }
  //==================single test data=====================

  List<String> selectedAns = [];

  void changeSelectedAns(val, index) {
    selectedAns[index] = val;
    emit(ChangeSelectedAnsState());
  }

  PageController? pageController = PageController();
  int? currentPage = 0;
  void changeCurrentPage(newIndex) {
    currentPage = newIndex;
    emit(ChangeSelectedAnsState());
  }

  List<bool>? isAttemptExpanded = [];

  void changeAttemptExpanedState() {

   
    emit(ChangeAttemptExpandedState());
  }

//============================get course exam======================
  CourseExamModel? courseExamModel;
  List<Questions> qusetionList = [];
  int? examId;
  String? errorCourseMsg;
  Future<void> getCourseExam(context, contentChildId) async {
    userAnswers=[];
    emit(GetCourseTestLoadingState());
    try {
      var res = await TestRepositories.getCoursesExam(
        contentChildId[0],
      );

      if (res['status'] < 300) {
        courseExamModel = CourseExamModel.fromJson(res);

        qusetionList = courseExamModel?.data?.questions ?? [];
        selectedAns =
            List.generate(qusetionList.length, (index) => 'not_answered');
      for(var item in qusetionList){
                                    if (item.type ==
                                        'matching') {
                                      var j = json.decode(
                                        item.question!);
                                      for (var item in j) {
                                        userAnswers!
                                            .add(MQuestion.fromJson(item));
                                      }
                                    }
                                  

            }
        emit(GetCourseTestLoadedState());
      } 
      else if(res['status']==400){
        errorCourseMsg=res['data'];
        AppUtil.flushbarNotification( res['data']);
        emit(TestTimeEndedErrorState());
      }
      else {
                errorCourseMsg=res['data']['msg'];

        examId = res['data']['exam'];
        AppUtil.flushbarNotification( res['data']['msg']);
        emit(TestTimeEndedErrorState());
      }
    } catch (error) {
      emit(GetCourseTestErrorState());
    }
  }
bool isVideo=false;
  void change() {
    emit(ChangeSelectedAnsState());
  }

  Future<void> submitTestAnswers(context,
      {List<int>? qIds, int? examId, List? answers}) async {
    emit(SubmitCourseTestLoadingState());
    try {
      Map<String, dynamic> q = {};
      for (int i = 0; i < qIds!.length; i++) {
        q.addAll({'true_answers[$i]': answers![i]});
      }
      Map<String, dynamic> query = {
        'questions': qIds.join(','),
        'exam_id': '${examId!}',
      };
      query.addAll(q);
      await TestRepositories.coursesExamSubmition(query: query);
      emit(SubmitCourseTestLoadedState());

      Navigator.pop(context);
    } catch (error) {
      emit(SubmitCourseTestErrorState());
    }
  }

//===================course exame result==================
  SutdentExamResultModel? sutdentExamResultModel;
  List<String> badResultSubjectList = [];
  String? errorMsg;
  Future<void> getCoursesExamResult(exameId, context) async {
    emit(GetExameResultLoadingState());
    try {
      var res = await TestRepositories.getCoursesExamResult(exameId);

      if (res['status'] < 300) {
        sutdentExamResultModel = SutdentExamResultModel.fromJson(res);

        testTrialInfo.add((sutdentExamResultModel!.data!.rightAnswers! /
                    sutdentExamResultModel!.data!.questions!.length *
                    100)
                .toString() +
            '%');
        testTrialInfo
            .add(sutdentExamResultModel!.data!.rightAnswers.toString());
        testTrialInfo
            .add(sutdentExamResultModel!.data!.wrongAnswers!.length.toString());
        testTrialInfo
            .add(sutdentExamResultModel!.data!.uncompletedAnswers.toString());

        for (var item in sutdentExamResultModel!.data!.answers!) {
          var question = sutdentExamResultModel!.data!.questions!
              .firstWhere((element) => element.id == item.questionId);
          if (item.type != '1') {
            if (!badResultSubjectList.contains(question.subject)) {
              badResultSubjectList.add(question.subject!);
            }
          } 
        }
        emit(GetExameResultLoadedState());
      } else {
        AppUtil.flushbarNotification( res['data']);
        errorMsg = res['data'];
        emit(GetExameResultErrorState());
      }
    } catch (error) {
      emit(GetExameResultErrorState());
    }
  }

//==========================static data===========================
  List<TestTrialCardModel> containerTitles = [
    TestTrialCardModel(
        color: AppUi.colors.activeColor, title: 'final_degree'.tr()),
    TestTrialCardModel(
        title: 'correct_answers'.tr(), color: AppUi.colors.correctCardColor),
    TestTrialCardModel(
        title: 'wrong_answers'.tr(), color: AppUi.colors.buttonColor),
    TestTrialCardModel(
        title: 'not_answered'.tr(), color: AppUi.colors.emptyAnsCardColor)
  ];
  List<String> testTrialInfo = [];

  //=================get the contest exam===================
  CourseExamModel? contestExamModel;
  void changeSelectedContestAns(val, index) {
    selectedAns[index] = val;
    emit(ChangeSelectedAnsState());
  }

  int? contestExamId;
  String? generalExamErrorMsg;
  Future<void> getContestExam(contestId, context,{isTrial=false}) async {
    emit(GetContestExamLoadingState());
    qusetionList = [];
    selectedAns = [];
    userAnswers=[];
    generalExamErrorMsg = '';
    try {
      var res = await ContestRepositories.getContestExam(contestId);
      if (res['status'] < 300) {
        contestExamModel = CourseExamModel.fromJson(res);
        qusetionList = contestExamModel?.data?.questions ?? [];

        selectedAns =
            List.generate(qusetionList.length, (index) => 'not_answered');
            
            for(var item in qusetionList){
                                    if (item.type ==
                                        'matching') {
                                      var j = json.decode(
                                        item.question!);
                                      for (var item in j) {
                                        userAnswers!
                                            .add(MQuestion.fromJson(item));
                                      }
                                    }
                                  

            }
        emit(GetContestExamLoadedState());
      } else {
        if (res['data'] is String) {
          generalExamErrorMsg = res['data'];
 if(!isTrial){
          AppUtil.flushbarNotification( res['data']);
 }
        } else {
          if(!isTrial){
          AppUtil.flushbarNotification( res['data']['msg']);
          }
          contestExamId = res['data']['exam'];
          generalExamErrorMsg = res['data']['msg'];
        }
        emit(GetContestExamErrorState());
      }
    } catch (error) {
      emit(GetContestExamErrorState());
    }
  }

//==============================get exam attempts=====================
  AttemptsModel? attemptsModel;
  List<SingleAttempt> attemptsList = [];
  Future<void> getHomeworkExamAttempts(examId) async {
    emit(GetGeneralExamAttempetsLoadingState());

    try {
      var res = await TestRepositories.getGeneralExamAttempts(examId);
      if (res['status'] < 300) {
        attemptsModel = AttemptsModel.fromJson(res);
        attemptsList = attemptsModel?.data ?? [];
        isAttemptExpanded =
            List.generate(attemptsList.length, ((index) => false));
      }
      emit(GetGeneralExamAttempetsLoadedState());
    } catch (error) {
      emit(GetGeneralExamAttempetsErrorState());
    }
  }

//=========================get homework exam attempts=========================

  Future<void> getGeneralExamAttempts(examId) async {
    emit(GetHomeworkExamLoadingState());

    try {
      var res = await TestRepositories.getGeneralExamAttempts(examId);
      if (res['status'] < 300) {
        attemptsModel = AttemptsModel.fromJson(res);
        attemptsList = attemptsModel?.data ?? [];
        isAttemptExpanded =
            List.generate(attemptsList.length, ((index) => false));
      }
      emit(GetHomeworkExamLoadedState());
    } catch (error) {
      emit(GetHomeworkExamErrorState());
    }
  }
  //=========================submit contest exam Result=================
  Future<void> submitContestExam(
      {contestId, qIds, answers, contestExamId, context}) async {
    emit(SubmitContestExamLoadingState());
    try {
      Map<String, dynamic> q = {};
      for (int i = 0; i < qIds!.length; i++) {
        q.addAll({'true_answers[$i]': answers![i]});
      }
      Map<String, dynamic> query = {
        'questions': qIds.join(','),
        'exam_id': '${contestExamId!}',
      };
      query.addAll(q);
      var res = await ContestRepositories.contestExamSubmition(query: query);
      if (res['status'] < 300) {
        emit(SubmitContestExamLoadedState());

        Navigator.pop(context);
        AppUtil.flushbarNotification( res['data']['msg']);
      } else {
        AppUtil.flushbarNotification( res['data']);
        emit(SubmitContestExamErrorState());
      }
    } catch (error) {
      emit(SubmitContestExamErrorState());
    }
  }

  //====================get contest exam result====================

  Future<void> getContestExamResult(contestId, context,{istrial=false}) async {
    testTrialInfo = [];
    badResultSubjectList = [];
    sutdentExamResultModel = null;
    emit(GetContestExamResultLoadingState());

    try {
      var res = await ContestRepositories.getContestExamResult(contestId);

      if (res['status'] < 300) {
        sutdentExamResultModel = SutdentExamResultModel.fromJson(res);
        var studentDegree=0;
        var examTotalDegree=0;
        for(var item in  sutdentExamResultModel!.data!.answers!){
         studentDegree+= item.teacherDegree!;
        examTotalDegree+= sutdentExamResultModel!.data!.questions!.firstWhere((element) =>element.id==item.questionId ).degree!;

        }
        testTrialInfo.add((studentDegree /
                    examTotalDegree *
                    100)
                .round()
                .toString() +
            '%');
        testTrialInfo
            .add(sutdentExamResultModel!.data!.rightAnswers.toString());
        testTrialInfo
            .add(sutdentExamResultModel!.data!.wrongAnswers!.length.toString());
        testTrialInfo
            .add(sutdentExamResultModel!.data!.uncompletedAnswers.toString());

        for (var item in sutdentExamResultModel!.data!.answers!) {
          var question = sutdentExamResultModel!.data!.questions!
              .firstWhere((element) => element.id == item.questionId);
          if (item.type != '1') {
            if (!badResultSubjectList.contains(question.subject)) {
              badResultSubjectList.add(question.subject!);
            }
          } 
        }
        emit(GetContestExamResultLoadedState());
      } else {
        if(!istrial){
        AppUtil.flushbarNotification( res['data']);
        }
        errorMsg = res['data'];
        emit(GetContestExamResultErrorState());
      }
    } catch (error) {
      emit(GetContestExamResultErrorState());
    }
  }


}
