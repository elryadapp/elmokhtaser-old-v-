import 'package:better_player/better_player.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/shared/constants.dart';
import 'package:elmoktaser_elshamel/shared/components/custom_video/custom_video.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomVideo extends StatefulWidget {
  final String? videoId;
  final String? courseImage;
  final int? courseId;
  const CustomVideo({Key? key, this.videoId, this.courseImage, this.courseId})
      : super(key: key);

  @override
  State<CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return widget.videoId != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
               if(!isSelected&& widget.courseImage!=null) 
               Image.network(
                  AppUi.assets.networkImageBaseLink + widget.courseImage!,
                  height: Constants.getHeight(context) * .25,
                  width: Constants.getwidth(context),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
           if(widget.courseImage!=null)   Container(
                  height: Constants.getHeight(context) * .25,
                  width: Constants.getwidth(context),
                  decoration: BoxDecoration(
                      color:!isSelected? AppUi.colors.titleColor.withOpacity(.4):AppUi.colors.bgColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: CircleAvatar(
                          backgroundColor: !isSelected? AppUi.colors.whiteColor:AppUi.colors.bgColor,
                          radius: 3.5.h,
                          child: Padding(
                            padding:  EdgeInsetsDirectional.only(bottom: 1.2.h,end: 2.2.w),
                            child: IconButton(
                              onPressed: () {
                                if(widget.courseId!=null){
                                CoursesCubit.get(context).addCourseToProgress(context, widget.courseId);
                                }

                                isSelected = true;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.play_arrow_rounded,
                                color: !isSelected? AppUi.colors.mainColor:AppUi.colors.bgColor,
                                size: 5.5.h,
                              ),
                            ),
                          ))),
                ),
              
                if(widget.courseImage!=null&&isSelected)  CustomVimeoPlayer(
        
                      id: widget.videoId!.split('?').first,
                      controlsConfig: BetterPlayerControlsConfiguration(
                          playIcon: Icons.play_circle,
                          
                          
                          enableFullscreen: true,
                          loadingWidget: AppUtil.appLoader(height: 12.h)),
                      autoPlay: true,
                      loaderColor: AppUi.colors.mainColor),
              ],
            ))
        : Container();
  }
}
