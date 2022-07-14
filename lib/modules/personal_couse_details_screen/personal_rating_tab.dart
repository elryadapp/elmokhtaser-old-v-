import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/models/courses_model.dart';
import 'package:elmoktaser_elshamel/modules/course_details/components/rating_card.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text_form.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class PersonalRatingTab extends StatefulWidget {
  final CoursesItem coursesItem;
  const PersonalRatingTab({Key? key, required this.coursesItem})
      : super(key: key);

  @override
  State<PersonalRatingTab> createState() => _PersonalRatingTabState();
}

class _PersonalRatingTabState extends State<PersonalRatingTab> {
  @override
  void initState() {
    var cubit = CoursesCubit.get(context);

    if (widget.coursesItem.rated!) {
      cubit.commentTextEditingController.text = widget.coursesItem.comments!
              .firstWhere((element) => element.me == true)
              .comment ??
          '';
      cubit.rate = double.parse(widget.coursesItem.comments!
          .firstWhere((element) => element.me == true)
          .rating!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.coursesItem.comments!.isEmpty
        ? Column(
            children: [
              Lottie.asset(AppUi.assets.empty, height: 30.h),
              AppText('there_are_no_ratings_yet'.tr())
            ],
          )
        : BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              var cubit = CoursesCubit.get(context);

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      child: Row(
                        children: [
                          AppText('general_rating'.tr() + ' : '),
                          AppText(
                            double.parse(
                                    widget.coursesItem.averageRate.toString())
                                .toString(),
                            color: Colors.amber,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: RatingBar.builder(
                              initialRating: double.parse(
                                  widget.coursesItem.averageRate.toString()),
                              ignoreGestures: true,
                              minRating: double.parse(
                                  widget.coursesItem.averageRate.toString()),
                              maxRating: double.parse(
                                  widget.coursesItem.averageRate.toString()),
                              itemSize: 2.h,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ),
                          AppText(
                            '(${widget.coursesItem.ratingCount})',
                            color: AppUi.colors.subTitleColor.withOpacity(.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: RationCard(
                                comments: widget.coursesItem.comments![index],
                              ),
                            )),
                        childCount: widget.coursesItem.comments!.length),
                  ),
                  if (!widget.coursesItem.rated!)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.7.w, vertical: 2.h),
                        child: AppButton(
                            onTap: () {
                              AppUtil.appDialoge(
                                  context: context,
                                  title: 'add_rate'.tr(),
                                  content: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                itemSize: 3.h,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  cubit.rate = rating;
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: AppTextFormFeild(
                                                  controller: cubit
                                                      .commentTextEditingController,
                                                  hint: 'add_rate'.tr(),
                                                  maxLines: 6,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                      child: AppButton(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    height: 4.h,
                                                    color: AppUi
                                                        .colors.buttonColor
                                                        .withOpacity(.9),
                                                    title: 'cancel'.tr(),
                                                  )),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Expanded(
                                                      child: AppButton(
                                                    onTap: () async {
                                                      if (cubit.rate == 0) {
                                                        AppUtil.flushbarNotification(
                                                            'select_the_rate_first'
                                                                .tr());
                                                      } else if (cubit
                                                              .commentTextEditingController
                                                              .text ==
                                                          '') {
                                                        AppUtil.flushbarNotification(
                                                            'add_a_comment_first'
                                                                .tr());
                                                      } else {
                                                        await cubit.addRate(context,
                                                            widget.coursesItem
                                                                .id);
                                                      }
                                                    },
                                                    color: AppUi
                                                        .colors.activeColor
                                                        .withOpacity(.9),
                                                    height: 4.h,
                                                    title: 'confirm'.tr(),
                                                  ))
                                                ],
                                              )
                                            ],
                                         
                                  )));
                            },
                            height: 5.5.h,
                            title: 'add_rate'.tr()),
                      ),
                    ),
                  if (widget.coursesItem.rated!)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.7.w, vertical: 2.h),
                        child: AppButton(
                            onTap: () {
                              AppUtil.appDialoge(
                                  context: context,
                                  title: 'update_rate'.tr(),
                                  content: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child:Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: double.parse(
                                                    widget.coursesItem.comments!
                                                        .firstWhere((element) =>
                                                            element.me == true)
                                                        .rating!),
                                                minRating: 1,
                                                itemSize: 3.h,
                                                allowHalfRating: true,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  cubit.rate = rating;
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: AppTextFormFeild(
                                                  controller: cubit
                                                      .commentTextEditingController,
                                                  hint: 'update_rate'.tr(),
                                                  maxLines: 6,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                      child: AppButton(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    height: 4.h,
                                                    color: AppUi
                                                        .colors.buttonColor
                                                        .withOpacity(.9),
                                                    title: 'cancel'.tr(),
                                                  )),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Expanded(
                                                      child: AppButton(
                                                    onTap: () async {
                                                      await cubit.updateRate(
                                                          widget.coursesItem
                                                              .comments!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .me ==
                                                                      true)
                                                              .id,
                                                          widget
                                                              .coursesItem.id,context);
                                                    
                                                    },
                                                    color: AppUi
                                                        .colors.activeColor
                                                        .withOpacity(.9),
                                                    height: 4.h,
                                                    title: 'confirm'.tr(),
                                                  ))
                                                ],
                                              )
                ])
                                  ));
                            },
                            height: 5.5.h,
                            title: 'update_rate'.tr()),
                      ),
                    )
                ],
              );
            },
          );
  }
}
