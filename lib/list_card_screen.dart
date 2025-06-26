import 'dart:math';

import 'package:flutter/material.dart';

class CardDeckScreen extends StatefulWidget {
  const CardDeckScreen({super.key});

  @override
  State<CardDeckScreen> createState() => _CardDeckScreenState();
}

class _CardDeckScreenState extends State<CardDeckScreen>
    with TickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.orangeAccent,
    Colors.lightBlueAccent,
    Colors.pinkAccent,
    Colors.greenAccent,
  ];

  late AnimationController _controller;
  late Animation<double> _moveUp;
  late Animation<double> _moveForward;
  late Animation<double> _rotation;

  int? _animatingIndex;
  bool _isAnimating = false;
  bool _swipeToLeft = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _moveUp = Tween<double>(begin: 0, end: -120).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _moveForward = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotation = Tween<double>(begin: 0, end: -pi / 12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  void _triggerCardSwap(bool swipeToLeft) async {
    if (_isAnimating) return;
    setState(() {
      _animatingIndex = swipeToLeft ? _colors.length - 1 : 0;
      _swipeToLeft = swipeToLeft;
      _isAnimating = true;
    });
    await _controller.forward(from: 0);
    setState(() {
      if (swipeToLeft) {
        final last = _colors.removeLast();
        _colors.insert(0, last);
      } else {
        final first = _colors.removeAt(0);
        _colors.add(first);
      }
      _animatingIndex = null;
      _isAnimating = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    if (_isAnimating) return;
    setState(() {
      _animatingIndex = _colors.length - 1;
      _isAnimating = true;
    });
    await _controller.forward(from: 0);
    setState(() {
      final last = _colors.removeLast();
      _colors.insert(0, last);
      _animatingIndex = null;
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.7;
    const cardHeight = 220.0;

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: SizedBox(
            width: cardWidth + 60,
            height: cardHeight + 55,
            child: Stack(
              clipBehavior: Clip.none,
              children: List.generate(_colors.length, (index) {
                final reverseIndex = _colors.length - index - 1;
                final angle =
                    (reverseIndex % 2 == 0 ? 1 : -1) * (4.0 + reverseIndex);
                final dx = (reverseIndex - 2) * 14.0;
                final dy = reverseIndex * 6.0;

                final isAnimatingCard = index == _animatingIndex;

                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final double translateY =
                        isAnimatingCard ? _moveUp.value : 0;
                    final double translateX = isAnimatingCard
                        ? (_swipeToLeft
                            ? _moveForward.value
                            : -_moveForward.value)
                        : dx;
                    final double rotate = isAnimatingCard
                        ? (_swipeToLeft ? _rotation.value : -_rotation.value)
                        : angle * pi / 180;
                    final double scale = isAnimatingCard ? 1.05 : 1.0;
                    final double opacity = isAnimatingCard ? 1.0 : 1.0;

                    return Positioned(
                      top: dy + translateY,
                      left: translateX + 20,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(rotate)
                          ..scale(scale),
                        child: Opacity(
                          opacity: opacity,
                          child: Container(
                            width: cardWidth,
                            height: cardHeight,
                            decoration: BoxDecoration(
                              color: _colors[index],
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
