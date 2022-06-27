
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/_exports.dart';

class TeamWorkCard extends StatelessWidget {
  final TeamItem team;
  const TeamWorkCard({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      decoration: BoxDecoration(color: AppUi.colors.whiteColor, boxShadow: [
        BoxShadow(blurRadius: 5, color: AppUi.colors.shadeColor)
      ]),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.network(
                  AppUi.assets.networkImageBaseLink + team.image!,
                  width: 40.w,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: AppText(
                team.name ?? '',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: AppText(
              team.job ?? '',
              fontSize: 10.sp,
            ),
          )
        ],
      ),
    );
  }
}
