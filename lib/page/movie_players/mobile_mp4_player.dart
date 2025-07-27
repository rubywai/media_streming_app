import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class MobileMp4Player extends StatefulWidget {
  const MobileMp4Player({
    super.key,
    required this.link,
    required this.resolutions,
    required this.title,
  });
  final String link;
  final Map<String, String> resolutions;
  final String title;

  @override
  State<MobileMp4Player> createState() => _MobileMp4PlayerState();
}

class _MobileMp4PlayerState extends State<MobileMp4Player> {
  late BetterPlayerController _controller;
  @override
  void initState() {
    super.initState();
    BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableAudioTracks: false,
        enableSubtitles: false,
        qualitiesIcon: Icons.video_camera_back_outlined,
        enableQualities: widget.resolutions.isNotEmpty,
      ),
    );
    _controller = BetterPlayerController(configuration);
    _controller.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.link,
        resolutions: widget.resolutions,
      ),
    );
    _controller.play();
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
