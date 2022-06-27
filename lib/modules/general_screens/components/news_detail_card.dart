import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class NewsDetailCard extends StatefulWidget {
  final int newsId;
  const NewsDetailCard({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetailCard> createState() => _NewsDetailCardState();
}

class _NewsDetailCardState extends State<NewsDetailCard> {
  @override
  void initState() {
    ServicesCubit.get(context).getSingleNewsData(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=ServicesCubit.get(context);
        return BuildCondition(
          condition: state is NewsLoadingState ,
          builder: (context)=>AppUtil.appLoader(),
          fallback: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppUi.colors.whiteColor,
                    boxShadow: [
                      BoxShadow(color: AppUi.colors.borderColor, blurRadius: 5)
                    ]),
                width: 90.w,
                margin: EdgeInsets.only(
                    top: 2.h, bottom: 1.2.h, left: 4.5.w, right: 4.5.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(AppUi.assets.networkImageBaseLink+cubit.singleNewsModel!.data!.image!)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(IconBroken.Calendar,color: AppUi.colors.mainColor,),
                         const SizedBox(
                          width: 5,
                        ),
                        AppText(
                            DateFormat.yMd().format(DateTime.parse(cubit.singleNewsModel!.data!.createdAt!))),
                       
                        
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                      child: AppText(
                       cubit.singleNewsModel!.data!.title!,
                        maxLines: 2,
                        height: 1.7,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    AppText(
                      cubit.singleNewsModel!.data!.content!,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}
