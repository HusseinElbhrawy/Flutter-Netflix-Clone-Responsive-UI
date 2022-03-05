import 'package:flutter/material.dart';
import 'package:netflix_clone_responsive_ui/widgets/play_button.dart';
import 'package:netflix_clone_responsive_ui/widgets/responsive_widget.dart';
import 'package:netflix_clone_responsive_ui/widgets/vertical_icon_button.dart';
import 'package:video_player/video_player.dart';

import '../models/content_model.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    Key? key,
    required this.sintelContent,
  }) : super(key: key);
  final Content sintelContent;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: _ContentHeaderDesktop(sintelContent: sintelContent),
      mobile: _ContentHeaderMobile(sintelContent: sintelContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  const _ContentHeaderMobile({
    Key? key,
    required this.sintelContent,
  }) : super(key: key);
  final Content sintelContent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                sintelContent.imageUrl,
              ),
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: AlignmentDirectional.bottomEnd,
              end: AlignmentDirectional.topEnd,
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(
              sintelContent.titleImageUrl.toString(),
            ),
          ),
        ),
        PositionedDirectional(
          end: 0.0,
          start: 0.0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(title: 'List', icon: Icons.add, onTap: () {}),
              const PlayButton(),
              VerticalIconButton(title: 'Info', icon: Icons.info, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  const _ContentHeaderDesktop({
    Key? key,
    required this.sintelContent,
  }) : super(key: key);
  final Content sintelContent;

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late final VideoPlayerController _videoPlayerController;
  bool isMuted = true;
  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.sintelContent.videoUrl.toString())
          ..initialize().then(
            (value) {
              setState(() {});
            },
          )
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.sintelContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: AlignmentDirectional.bottomEnd,
                  end: AlignmentDirectional.topEnd,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(
                    widget.sintelContent.titleImageUrl.toString(),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.sintelContent.description.toString(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const PlayButton(),
                    const SizedBox(width: 16.0),
                    TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () => print('More Info'),
                      icon: const Icon(Icons.info_outlined),
                      label: Text(
                        'More Info',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isMuted
                                ? _videoPlayerController.setVolume(100)
                                : _videoPlayerController.setVolume(0);

                            isMuted = _videoPlayerController.value.volume == 0;
                          });
                        },
                        icon: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                  ],
                ),
              ],
            ),
            start: 60.0,
            end: 60.0,
            bottom: 150.0,
          )
        ],
      ),
    );
  }
}
