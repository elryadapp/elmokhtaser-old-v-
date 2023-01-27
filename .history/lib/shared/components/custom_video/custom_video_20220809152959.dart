
import 'package:better_player/better_player.dart';
import 'package:elmoktaser_elshamel/shared/components/custom_video/link.dart';
import 'package:flutter/material.dart';
class CustomVimeoPlayer extends StatefulWidget {
  final String? id;

  final bool autoPlay;

  final bool looping;

  final bool? allowFullScreen;

  final BetterPlayerControlsConfiguration? controlsConfig;

  final Color? loaderColor;

  final Color? loaderBackgroundColor;

const  CustomVimeoPlayer({
    required this.id,
    this.autoPlay = false,
    this.looping = false,
    this.controlsConfig,
    this.loaderColor,
    this.loaderBackgroundColor,
    this.allowFullScreen = false,
    Key? key,
  })  : assert(id != null && allowFullScreen != null),
        super(key: key);

  @override
  _CustomVimeoPlayerState createState() => _CustomVimeoPlayerState();
}

class _CustomVimeoPlayerState extends State<CustomVimeoPlayer> {
  int? position;
  bool fullScreen = false;

  late QualityLinks _quality;
  dynamic _qualityValue;
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    fullScreen = widget.allowFullScreen!;

    _quality = QualityLinks(widget.id);

    _quality.getQualitiesSync().then((value) {
      _qualityValue = value[value.lastKey()];

      Map<String, String> resolutionsMap = {};
      value.keys.forEach((key) {
        String processedKey = key.split(" ")[0];
        resolutionsMap[processedKey] = value[key];
      });

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, _qualityValue,
          resolutions: resolutionsMap);

      setState(() {
        _betterPlayerController = BetterPlayerController(
            BetterPlayerConfiguration(
              autoPlay: widget.autoPlay,
              looping: widget.looping,
              fullScreenByDefault: fullScreen,
              controlsConfiguration: widget.controlsConfig == null
                  ? const BetterPlayerControlsConfiguration()
                  : widget.controlsConfig as BetterPlayerControlsConfiguration,
            ),
            betterPlayerDataSource: betterPlayerDataSource);
      });

    
    });

  

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _betterPlayerController == null
          ?Container()
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                controller: _betterPlayerController as BetterPlayerController,
              ),
            ),
    );
  }


}
