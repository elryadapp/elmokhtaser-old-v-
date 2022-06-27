
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';


class RationCard extends StatelessWidget {
  final Comments comments;
  const RationCard({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${comments.user}',
              color: AppUi.colors.mainColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  AppText(
                    '${double.parse(comments.rating.toString())}',
                    color: Colors.amber,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RatingBar.builder(
                      initialRating: double.parse(comments.rating.toString()),
                      minRating: 1,
                      itemSize: 2.h,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  )
                ],
              ),
            ),
             AppText(comments.comment!)
          ],
        ),
      ),
    );
  }
}
