import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FocusOrbWidget extends StatefulWidget {
  final double size;
  final bool isPulsing;
  final Widget? child;

  const FocusOrbWidget({
    super.key,
    this.size = 120,
    this.isPulsing = true,
    this.child,
  });

  @override
  State<FocusOrbWidget> createState() => _FocusOrbWidgetState();
}

class _FocusOrbWidgetState extends State<FocusOrbWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.15, end: 0.35).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isPulsing) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(FocusOrbWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPulsing && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isPulsing && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: widget.size * (widget.isPulsing ? _scaleAnimation.value * 1.3 : 1.3),
                height: widget.size * (widget.isPulsing ? _scaleAnimation.value * 1.3 : 1.3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lavenderSoft(context).withValues(
                    alpha: widget.isPulsing ? _opacityAnimation.value : 0.2,
                  ),
                ),
              ),
              Container(
                width: widget.size * (widget.isPulsing ? _scaleAnimation.value * 1.1 : 1.1),
                height: widget.size * (widget.isPulsing ? _scaleAnimation.value * 1.1 : 1.1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryAccent(context).withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryAccent(context),
                ),
                child: Center(
                  child: widget.child ??
                      Container(
                        width: widget.size * 0.4,
                        height: widget.size * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.background(context),
                        ),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
