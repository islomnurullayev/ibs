import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibs/theme/style.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Future<void> initializeVideoPlayerFuture;
  const VideoPlayerWidget(
      {Key? key,
      required this.controller,
      required this.initializeVideoPlayerFuture})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  double value = 20;
  late String position;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;
  }

  String videoposition(Duration duration) {
    late String val;
    int minute = duration.inSeconds ~/ 60;
    int seconds = duration.inSeconds % 60;
    String fixedSeconds = seconds >= 10 ? "$seconds" : "0$seconds";

    String fixedminutes = duration.inMinutes >= 10 ? "$minute" : "0$minute";
    val = duration.inSeconds > 60
        ? "$fixedminutes : $fixedSeconds"
        : "00:$fixedSeconds";

    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Style.colors.black,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, VideoPlayerValue controller, __) {
                return FutureBuilder(
                  future: widget.initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_controller),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                "${videoposition(controller.position)} / ${videoposition(controller.duration)}",
                                style: Style.body1.copyWith(
                                  color: Style.colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: EdgeInsets.zero,
              colors: VideoProgressColors(
                backgroundColor: Style.colors.grey,
                bufferedColor: Style.colors.grey,
                playedColor: Style.colors.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Duration currentPosition = _controller.value.position;
                    Duration targetPosition =
                        currentPosition - const Duration(seconds: 5);
                    _controller.seekTo(targetPosition);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 35,
                    color: Style.colors.primary,
                  ),
                ),
                IconButton(
                  color: Style.colors.black,
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  icon: _controller.value.isPlaying
                      ? Icon(
                          Icons.pause,
                          size: 35,
                          color: Style.colors.primary,
                        )
                      : Icon(
                          Icons.play_arrow_rounded,
                          size: 35,
                          color: Style.colors.primary,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    Duration currentPosition = _controller.value.position;
                    Duration targetPosition =
                        currentPosition + const Duration(seconds: 5);
                    _controller.seekTo(targetPosition);
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    size: 35,
                    color: Style.colors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
