import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class MobileVideoPlayer extends StatefulWidget {
  const MobileVideoPlayer({
    super.key,
    required this.link,
    required this.resolutions,
    required this.title,
    required this.type,
  });
  final String link;
  final Map<String, String> resolutions;
  final String title;
  final String type;

  @override
  State<MobileVideoPlayer> createState() => _MobileVideoPlayerState();
}

class _MobileVideoPlayerState extends State<MobileVideoPlayer> {
  late BetterPlayerController _controller;
  @override
  void initState() {
    super.initState();
    bool isTV = GetIt.I.get<bool>();
    if (!isTV) {
      SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
    }
    BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
      autoPlay: isTV,
      fullScreenByDefault: isTV,
      overlay: Align(
        alignment: Alignment.topRight,
        child: Text(
          "Ruby Learner ",
        ),
      ),
      controlsConfiguration: BetterPlayerControlsConfiguration(
        playerTheme: isTV ? BetterPlayerTheme.tv : BetterPlayerTheme.tv,
        enableAudioTracks: false,
        enableSubtitles: widget.type == 'hls',
        qualitiesIcon: Icons.video_camera_back_outlined,
        enableQualities: widget.resolutions.isNotEmpty || widget.type == 'hls',
        progressBarBackgroundColor: Colors.red,
        progressBarBufferedColor: Colors.green,
      ),
    );
    _controller = BetterPlayerController(configuration);
    _controller.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.link,
        resolutions: widget.resolutions,
        videoFormat: widget.type == 'hls'
            ? BetterPlayerVideoFormat.hls
            : BetterPlayerVideoFormat.other,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BetterPlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
