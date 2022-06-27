import 'package:buildcondition/buildcondition.dart';
import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/components/news_item_card.dart';
import 'package:elmoktaser_elshamel/shared/components/animated_list_handler.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
    ServicesCubit.get(context).getAllNewsData();
    super.initState();
  }

  fetchData({name}) async {
    var cubit = ServicesCubit.get(context);

    cubit.page++;
    cubit.getAllNewsData(page: cubit.page);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ServicesCubit.get(context);
        return Scaffold(
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'news'.tr(),
            ),
            body: BuildCondition(
                condition: state is NewsLoadingState,
                builder: (context) => AppUtil.appLoader(),
                fallback: (context) {
                  return Stack(
                    children: [
                      AnimatedListHandler(
                        scrollController: scrollController,
                        children: [
                        ...cubit.newsList.map((e) => NewsItemCard(
                              newsItem: e,
                            ))
                      ]),
                       Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                color: cubit.newsModel!.data!.isEmpty?AppUi.colors.buttonColor.withOpacity(.8):Colors.transparent,

                ),

                margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                height: state is PaginationLoadingState ?cubit.newsModel!.data!.isEmpty
                 ? 50:100 : 0,
                width: double.infinity,
                child: Center(
                  child: cubit.newsModel!.data!.isEmpty?
           AppText('there_is_no_more_news'.tr(),color: AppUi.colors.whiteColor,)
                      : AppUtil.appLoader(height: 30.h),
                ),
              ),
            )
                    ],
                  );
                }));
      },
    );
  }
}
