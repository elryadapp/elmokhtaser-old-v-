import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/layout/lost_internet_connection.dart';
import 'package:elmoktaser_elshamel/modules/personal_couse_details_screen/components/personal_course_body.dart';

import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalCoursesDetailsScreen extends StatefulWidget {
  final dynamic courseId;
  const PersonalCoursesDetailsScreen({Key? key, required this.courseId})
      : super(key: key);

  @override
  State<PersonalCoursesDetailsScreen> createState() =>
      _PersonalCoursesDetailsScreenState();
}

class _PersonalCoursesDetailsScreenState
    extends State<PersonalCoursesDetailsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    var cubit = CoursesCubit.get(context);
    cubit.personalDetailsTabController = TabController(length: 5, vsync: this);
    cubit.getCourseById(widget.courseId, context);
    var connection = ConnectivityCubit.get(context);
    connection.connectivitySubscription =
        connection.connectivity.onConnectivityChanged.listen((event) {
      connection.checkConnection(connectivity: connection.connectivity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CoursesCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: '',
          ),
          body: BlocBuilder<ConnectivityCubit, ConnectivityCubitState>(
            builder: (context, state) {
              return !ConnectivityCubit.get(context).hasConnection
                  ? const LostInternetConnection()
                  :PersonalCourseBody(courseId: widget.courseId);
            },
          ),
        );
      },
    );
  }
}
