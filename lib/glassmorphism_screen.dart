import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GlassmorphismScreen extends StatefulWidget {
  const GlassmorphismScreen({super.key});

  @override
  State<GlassmorphismScreen> createState() => _GlassmorphismScreenState();
}

class _GlassmorphismScreenState extends State<GlassmorphismScreen> {
  late VideoPlayerController _videoController;
  Offset lensPosition = const Offset(200, 300);

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/5.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            lensPosition = details.localPosition;
          });
        },
        child: Stack(
          children: [
            /*
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/1.jpg'),
                  // Remplace par une image de ton projet
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
            if (_videoController.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            Positioned(
              left: lensPosition.dx - 75,
              top: lensPosition.dy - 75,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.25),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                          radius: 1.5,
                          center: Alignment.topLeft,
                        ),
                      ),
                      child: const Icon(Icons.blur_on,
                          size: 60, color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
