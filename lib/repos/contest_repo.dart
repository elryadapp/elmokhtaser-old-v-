import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/network/remote/dio_helper.dart';
import 'package:elmoktaser_elshamel/shared/network/remote/end_points.dart';

class ContestRepositories {
  static Future<Map<String, dynamic>> getAllContest() async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.contest,
    );
    return res.data;
  }

  static Future<Map<String, dynamic>> getSingleContest(contestId) async {
    var res = await DioHelper.getData(
      url: '${ApiEndPoints.contest}/$contestId',
    );
    return res.data;
  }

  static Future<Map<String, dynamic>> getContestExam(contestId) async {
    var res = await DioHelper.getData(
      url: '${ApiEndPoints.getContest}/$contestId',
      token:'Bearer ${Constants.token}'
    );
    return res.data;
  }

   static Future<Map<String, dynamic>> contestExamSubmition({Map<String, dynamic>? query}) async {
    var res = await DioHelper.postData(
      
      url:ApiEndPoints.contestSubmit,
      data: query,
      token:'Bearer ${Constants.token}'
    );
    return res.data;
  }

   static Future<Map<String, dynamic>> getContestExamResult(contestId) async {
    var res = await DioHelper.getData(
      
      url: '${ApiEndPoints.getContestResult}/$contestId',
            token:'Bearer ${Constants.token}'


    );
    return res.data;
  }
}
