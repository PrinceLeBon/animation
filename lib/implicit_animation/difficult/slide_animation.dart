import 'package:flutter/material.dart';

final List<OnboardingPageModel> onboardingPages = [
  OnboardingPageModel(
    color: const Color(0xFF2E294E),
    assetPath: Icons.palette,
    title: "Pure Flutter",
    subtitle:
        "The power of CustomPainter to create unique and fluid interfaces.",
  ),
  OnboardingPageModel(
    color: const Color(0xFF1B4965),
    assetPath: Icons.gesture,
    title: "Intuitive Gestures",
    subtitle: "Use GestureDetector for rich and responsive interaction.",
  ),
  OnboardingPageModel(
    color: const Color(0xFF4A694E),
    assetPath: Icons.bolt,
    title: "Hot Reload",
    subtitle:
        "Instantly see your changes, dramatically speeding up your development cycle.",
  ),
  OnboardingPageModel(
    color: const Color(0xFF8D4B4B),
    assetPath: Icons.widgets_outlined,
    title: "Expressive UI",
    subtitle:
        "Build beautiful, custom user interfaces with a rich set of widgets.",
  ),
  OnboardingPageModel(
    color: const Color(0xFF895B8A),
    assetPath: Icons.speed,
    title: "Wicked Fast",
    subtitle:
        "Achieve native performance on both iOS and Android from a single codebase.",
  ),
  OnboardingPageModel(
    color: const Color(0xFFD8A48F),
    assetPath: Icons.people_outline,
    title: "Community Powered",
    subtitle:
        "Leverage a vast ecosystem of open-source packages and a supportive community.",
  ),
  OnboardingPageModel(
    color: const Color(0xFF2A5D6A),
    assetPath: Icons.rocket_launch,
    title: "Ready to Launch?",
    subtitle:
        "Combine everything to surprise and delight your users. Let's get started!",
  ),
];

class LiquidOnboarding extends StatefulWidget {
  const LiquidOnboarding({super.key});

  @override
  _LiquidOnboardingState createState() => _LiquidOnboardingState();
}

class _LiquidOnboardingState extends State<LiquidOnboarding>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  int _currentPage = 0;

  // CHANGEMENT : La progression peut maintenant être négative (swipe à droite) ou positive (swipe à gauche)
  double _swipeProgress = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      // L'animation mettra à jour la progression du swipe
    )..addListener(() {
        setState(() {
          _swipeProgress = _animationController.value;
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
    _animationController.stop(); // Arrête toute animation en cours
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    setState(() {
      // Met à jour la progression en fonction du delta du glissement
      _swipeProgress -=
          details.primaryDelta! / MediaQuery.of(context).size.width;
      // Limite la valeur entre -1 (swipe complet à droite) et 1 (swipe complet à gauche)
      _swipeProgress = _swipeProgress.clamp(-1.0, 1.0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;

    // CHANGEMENT : Logique pour décider de la direction
    double target;
    // Va à la page suivante
    if (_swipeProgress > 0.5 || details.primaryVelocity! < -800) {
      target = 1.0;
    }
    // Va à la page précédente
    else if (_swipeProgress < -0.5 || details.primaryVelocity! > 800) {
      target = -1.0;
    }
    // Revient à la position initiale
    else {
      target = 0.0;
    }

    _animationController.value = _swipeProgress;
    _animationController
        .animateTo(
      target,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    )
        .then((_) {
      // Met à jour l'index de la page une fois l'animation terminée
      setState(() {
        if (target == 1.0 && _currentPage < onboardingPages.length - 1) {
          _currentPage++;
        } else if (target == -1.0 && _currentPage > 0) {
          _currentPage--;
        }
        // Réinitialise la progression pour le prochain geste
        _swipeProgress = 0.0;
        _animationController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // CHANGEMENT : Logique pour déterminer quelle page afficher en fond et au premier plan
    Widget backgroundPage;
    Widget foregroundPage;

    if (_swipeProgress >= 0) {
      // Swipe vers la gauche (ou idle)
      backgroundPage = PageContent(model: onboardingPages[_currentPage]);

      // Assure qu'on ne swipe pas au-delà de la dernière page
      if (_currentPage < onboardingPages.length - 1) {
        foregroundPage = ClipPath(
          clipper: LiquidClipper(progress: _swipeProgress),
          child: PageContent(model: onboardingPages[_currentPage + 1]),
        );
      } else {
        foregroundPage = Container();
      }
    } else {
      // Swipe vers la droite
      // La page de fond est la page précédente
      if (_currentPage > 0) {
        backgroundPage = PageContent(model: onboardingPages[_currentPage - 1]);
      } else {
        backgroundPage = Container();
      }

      // La page au premier plan est la page actuelle qui se fait "clipper"
      foregroundPage = ClipPath(
        clipper: LiquidClipper(progress: _swipeProgress),
        child: PageContent(model: onboardingPages[_currentPage]),
      );
    }

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Scaffold(
        body: Container(
          color: onboardingPages[_currentPage].color,
          // Couleur de fond principale
          child: Stack(
            children: [
              backgroundPage,
              foregroundPage,
              // Indicateur liquide sur le côté
              Positioned(
                top: size.height / 2 - 40,
                right: 0,
                child: LiquidIndicator(progress: _swipeProgress),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LiquidClipper extends CustomClipper<Path> {
  // progress peut maintenant aller de -1.0 à 1.0
  final double progress;

  LiquidClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // CHANGEMENT : Logique différente selon la direction du swipe
    if (progress >= 0) {
      // Swipe de droite à gauche (révèle la page suivante)
      final startX = w - (w * progress);
      final controlPointX = w - (w * progress * 1.5).clamp(0, w);

      path.moveTo(w, 0);
      path.lineTo(startX, 0);
      path.quadraticBezierTo(controlPointX, h / 2, startX, h);
      path.lineTo(w, h);
      path.close();
    } else {
      // Swipe de gauche à droite (cache la page actuelle pour révéler la précédente)
      final p = progress.abs();
      final startX = w * p;
      final double controlPointX = (w * p * 1.5).clamp(0, w);

      // Le chemin doit couvrir la partie de l'écran à conserver
      path.moveTo(startX, 0);
      path.quadraticBezierTo(controlPointX, h / 2, startX, h);
      path.lineTo(w, h);
      path.lineTo(w, 0);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class IndicatorPainter extends CustomPainter {
  // progress peut maintenant aller de -1.0 à 1.0
  final double progress;
  final Paint _paint;

  IndicatorPainter({required this.progress})
      : _paint = Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // CHANGEMENT : La distance peut être négative, ce qui inverse la courbe naturellement
    final pullDistance = (progress * w * 0.8);

    path.moveTo(w, 0);
    path.lineTo(w, h);
    path.quadraticBezierTo(w - pullDistance, h / 2, w, 0);
    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PageContent extends StatelessWidget {
  final OnboardingPageModel model;

  const PageContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(model.assetPath, size: 80, color: Colors.white),
          const SizedBox(height: 40),
          Text(model.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(model.subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 18)),
        ],
      ),
    );
  }
}

class OnboardingPageModel {
  final Color color;
  final IconData assetPath;
  final String title;
  final String subtitle;

  OnboardingPageModel(
      {required this.color,
      required this.assetPath,
      required this.title,
      required this.subtitle});
}

class LiquidIndicator extends StatelessWidget {
  final double progress;

  const LiquidIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // Ce painter est celui qui dessine la forme liquide de l'indicateur
      painter: IndicatorPainter(progress: progress),
      size: const Size(60, 80),
    );
  }
}
