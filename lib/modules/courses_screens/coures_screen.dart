import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/layout/lost_internet_connection.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/courses_body_screen.dart';
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    var cubit = CoursesCubit.get(context);
    cubit.coursesList = [];
    cubit.getCourseCategories(context).then((value) => cubit.tabController =
        TabController(length: cubit.categoriesList.length + 1, vsync: this));
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
              titleText: 'courses'.tr(),
            ),
            body: BlocBuilder<ConnectivityCubit, ConnectivityCubitState>(
              builder: (context, state) {
                var connectCubit = ConnectivityCubit.get(context);
                return !connectCubit.hasConnection
                    ? const LostInternetConnection()
                    : const CoursesBodyScreen();
              },
            ));
      },
    );
  }
}
