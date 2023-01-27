
import 'package:elmoktaser_elshamel/layout/_exports.dart';
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/_exports.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';


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
                          child: IconButton(
                            padding: EdgeInsets.zero,
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
                          ))),
                ),
              
                if(widget.courseImage!=null&&isSelected)
                VimeoVideoPlayer(
  vimeoPlayerModel: VimeoPlayerModel(
    url: 'https://vimeo.com/${widget.videoId!}',
    deviceOrientation: DeviceOrientation.portraitUp,
    systemUiOverlay: const [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
      ],
   ),
)
                  // CustomVimeoPlayer(
        
                  //     id: widget.videoId!,
                  //     controlsConfig: BetterPlayerControlsConfiguration(
                  //         playIcon: Icons.play_circle,
                          
                          
                  //         enableFullscreen: true,
                  //         loadingWidget: AppUtil.appLoader(height: 12.h)),
                  //     autoPlay: true,
                  //     loaderColor: AppUi.colors.mainColor),
              ],
            ))
        : Container();
  }
}
