import 'package:elmoktaser_elshamel/models/courses_model.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/rating_card.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class RatingTab extends StatelessWidget {
  final CoursesItem coursesItem;
  const RatingTab({Key? key, required this.coursesItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return coursesItem.comments!.isEmpty
        ? Column(
            children: [
              Lottie.asset(AppUi.assets.empty, height: 30.h),
              AppText('there_are_no_ratings_yet'.tr())
            ],
          )
        : CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  child: Row(
                    children: [
                      AppText('general_rating'.tr() + ' : '),
                      AppText(
                        double.parse(coursesItem.averageRate.toString())
                            .toString(),

                        color: Colors.amber,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: RatingBar.builder(
                          initialRating:
                              double.parse(coursesItem.averageRate.toString()),
                          minRating: 1,
                          itemSize: 2.h,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                              updateOnDrag: false,
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
                        '(${coursesItem.ratingCount})',
                        color: AppUi.colors.subTitleColor.withOpacity(.6),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => InkWell(
                        onTap: () {},
                        child: RationCard(
                          comments: coursesItem.comments![index],
                        )),
                    childCount: coursesItem.comments!.length),
              )
            ],
          );
  }
}
