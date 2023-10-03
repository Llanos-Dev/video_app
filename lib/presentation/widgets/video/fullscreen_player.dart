import 'package:flutter/material.dart';
import 'package:video_app/presentation/widgets/video/video_backgroung.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({super.key, required this.videoUrl, required this.caption});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controler = VideoPlayerController.asset(widget.videoUrl);
    controler.setVolume(0);
    controler.setLooping(true);
    controler.play();
  }

  @override
  void dispose() {
    controler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controler.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        return GestureDetector(
          onTap: () {
            if (controler.value.isPlaying) {
              controler.pause();
              return;
            }
            controler.play();
          },
          child: AspectRatio(
              aspectRatio: controler.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controler),
                  //grandiente
                  VideoBackground(stops: const [0.8, 1.0]),
                  //texto
                  Positioned(
                      bottom: 50,
                      left: 20,
                      child: _VideoCaption(
                        caption: widget.caption,
                      )),
                ],
              )),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: size.width * 0.6,
      child: Text(caption, maxLines: 2, style: titleStyle),
    );
  }
}
