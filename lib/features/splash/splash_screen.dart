import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

/// Splash screen displayed when the app launches.
/// Features a multi-layered animation sequence: floating logo,
/// sliding italic branding, shimmering tagline, and pulsing loader.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ── Animation Controllers ─────────────────────────────────────
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;
  late AnimationController _loaderController;
  late AnimationController _bgPulseController;

  // ── Logo Animations ───────────────────────────────────────────
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;

  // ── Text Animations ───────────────────────────────────────────
  late Animation<Offset> _textSlideUp;
  late Animation<double> _textOpacity;
  late Animation<double> _textScale;

  // ── Tagline Animations ────────────────────────────────────────
  late Animation<double> _taglineOpacity;
  late Animation<double> _taglineScale;

  // ── Background Pulse ──────────────────────────────────────────
  late Animation<double> _bgPulse;

  // ── Floating offset ───────────────────────────────────────────
  Offset _floatOffset = Offset.zero;
  final _floatAmplitude = 8.0;
  final _floatSpeed = 0.6;

  static const _navigateDelay = Duration(milliseconds: 3200);

  @override
  void initState() {
    super.initState();

    // ── Logo Controller ─────────────────────────────────────────
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 1.15), weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 0.95), weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0), weight: 40,
      ),
    ]).animate(CurvedAnimation(
      parent: _logoController, curve: Curves.easeOutBack,
    ));

    _logoRotation = Tween<double>(begin: -0.08, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    // ── Text Controller ─────────────────────────────────────────
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textSlideUp = Tween<Offset>(
      begin: const Offset(0.0, 0.6), end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController, curve: Curves.easeOutQuint,
    ));

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutBack),
    );

    // ── Tagline Controller ──────────────────────────────────────
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _taglineScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.elasticOut),
    );

    // ── Background Pulse ────────────────────────────────────────
    _bgPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bgPulse = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgPulseController, curve: Curves.easeInOutSine),
    );

    // ── Loader Controller ───────────────────────────────────────
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // ── Start animation sequence ────────────────────────────────
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) _taglineController.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) _loaderController.forward();
    });

    // ── Navigate after all animations ───────────────────────────
    Future.delayed(_navigateDelay, () {
      if (mounted) {
        final authProvider = context.read<AuthProvider>();
        if (authProvider.isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.appShell);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      }
    });

    // ── Start floating animation ────────────────────────────────
    _startFloating();
  }

  void _startFloating() {
    Future.doWhile(() async {
      if (!mounted) return false;
      await Future.delayed(const Duration(milliseconds: 16));
      if (!mounted) return false;
      final time = DateTime.now().millisecondsSinceEpoch / 1000;
      setState(() {
        _floatOffset = Offset(
          math.sin(time * _floatSpeed) * _floatAmplitude,
          math.cos(time * _floatSpeed * 0.7) * _floatAmplitude * 0.6,
        );
      });
      return true;
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _loaderController.dispose();
    _bgPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgPulse,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    AppColors.primaryRed,
                    const Color(0xFFB71C1C),
                    _bgPulse.value * 0.15,
                  )!,
                  Color.lerp(
                    AppColors.darkRed,
                    const Color(0xFF7F0000),
                    _bgPulse.value * 0.2,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // ── Floating Splash Image ──────────────────────
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _logoController,
                    _bgPulseController,
                  ]),
                  builder: (context, _) {
                    return Transform.translate(
                      offset: _floatOffset,
                      child: Transform.rotate(
                        angle: _logoRotation.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: Hero(
                            tag: 'app-logo',
                            child: Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accentGold
                                        .withValues(alpha: 0.15 + _bgPulse.value * 0.1),
                                    blurRadius: 30 + _bgPulse.value * 15,
                                    spreadRadius: _bgPulse.value * 5,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/assets/images/burgers/splash.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ── Decorative divider dots ───────────────────
                AnimatedBuilder(
                  animation: _taglineController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _taglineOpacity.value.clamp(0.0, 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentGold
                                  .withValues(alpha: 0.5 - i * 0.12),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // ── \"Glory Burger\" Italic Branding ────────────
                SlideTransition(
                  position: _textSlideUp,
                  child: FadeTransition(
                    opacity: _textOpacity,
                    child: ScaleTransition(
                      scale: _textScale,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accentGold,
                              AppColors.white,
                              AppColors.accentGold,
                            ],
                            stops: [
                              0.0,
                              0.4 + _bgPulse.value * 0.1,
                              1.0,
                            ],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'Glory Burger',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: AppColors.white,
                            letterSpacing: 2.5,
                            shadows: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // ── Tagline ───────────────────────────────────
                FadeTransition(
                  opacity: _taglineOpacity,
                  child: ScaleTransition(
                    scale: _taglineScale,
                    child: Text(
                      'Taste the Glory!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: AppColors.accentGold.withValues(alpha: 0.85),
                        letterSpacing: 4,
                        shadows: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // ── Animated Loading Indicator ────────────────
                AnimatedBuilder(
                  animation: _loaderController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _loaderController.value,
                      child: Column(
                        children: [
                          // Spinning ring loader
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}