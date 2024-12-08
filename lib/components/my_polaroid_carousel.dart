import 'dart:async';
import 'package:flutter/material.dart';

class Rotate {
  final double x;
  final double y;
  final double z;

  /// Value should be less like 0.001 for translationFactor 360 because rotate value depends on [translationFactor]
  const Rotate({
    double x = 0.0,
    double y = 0.0,
    double z = 0.0,
  })  : assert(x >= 0.0 && x <= 1.0, 'x must be between 0.0 and 1.0'),
        assert(y >= 0.0 && y <= 1.0, 'y must be between 0.0 and 1.0'),
        assert(z >= 0.0 && z <= 1.0, 'z must be between 0.0 and 1.0'),
        x = (x >= 0.0 && x <= 1.0) ? x : (x < 0.0 ? 0.0 : 1.0),
        y = (y >= 0.0 && y <= 1.0) ? y : (y < 0.0 ? 0.0 : 1.0),
        z = (z >= 0.0 && z <= 1.0) ? z : (z < 0.0 ? 0.0 : 1.0);
}

/// Decide the animation direction - [frontToBack] or [backToFront]
enum Order {
  frontToBack,
  backToFront,
}

/// Translation direction [left] or [right] or [top] or [bottom]
enum Translate {
  left,
  right,
  top,
  bottom,
}

class MyPolaroidCarousel extends StatefulWidget {
  final Order order;
  final List<Widget> children;
  final double translateFactor;
  final Translate translate;
  final Curve curve;
  final Duration duration;
  final Rotate rotate;

  /// This unique carousel seamlessly shuffles items from the front and back, creating an engaging user interface.
  const MyPolaroidCarousel(
      {Key? key,
      required this.children,
      this.order = Order.frontToBack,
      this.translate = Translate.right,
      required this.translateFactor,
      this.curve = Curves.easeInSine,
      this.duration = const Duration(seconds: 2),
      this.rotate = const Rotate()})
      : super(key: key);

  @override
  State<MyPolaroidCarousel> createState() => _PolaroidCarouselState();
}

class _PolaroidCarouselState extends State<MyPolaroidCarousel>
    with TickerProviderStateMixin {
  bool order = false;
  late Widget topWidget;
  late List<Widget> children;
  late AnimationController controller;
  late Animation<double> animation;
  bool isAnimating = false; // Track animation state

  @override
  void initState() {
    super.initState();
    children = widget.children;
    order = widget.order == Order.backToFront;
    createAnimation();

    order
        ? {
            topWidget = children.removeAt(0),
            children.insert(0, animatedWidget(topWidget)),
          }
        : {
            topWidget = children.removeLast(),
            children.add(animatedWidget(topWidget)),
          };

    controller.addStatusListener(listen);
  }

  void createAnimation() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );
    animation =
        Tween(begin: 0.0, end: widget.translateFactor).animate(curvedAnimation);
  }

  void renewController() {
    controller.dispose();

    createAnimation();

    order
        ? {
            children.removeLast(),
            children.add(topWidget),
            topWidget = children.removeAt(0),
            children.insert(0, animatedWidget(topWidget)),
          }
        : {
            children.removeAt(0),
            children.insert(0, topWidget),
            topWidget = children.removeLast(),
            children.add(animatedWidget(topWidget)),
          };

    setState(() {});

    controller.addStatusListener(listen);
  }

  void listen(AnimationStatus status) {
    print('Animation status: $status');
    if (status == AnimationStatus.completed) {
      order
          ? children.add(children.removeAt(0))
          : children.insert(0, children.removeLast());

      controller.reverse();
      setState(() {});

    } else if (status == AnimationStatus.dismissed) {
      renewController();
    }
  }

  Widget animatedWidget(Widget listItem) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
                widget.translate == Translate.left
                    ? -animation.value
                    : widget.translate == Translate.right
                        ? animation.value
                        : 0,
                widget.translate == Translate.top
                    ? -animation.value
                    : widget.translate == Translate.bottom
                        ? animation.value
                        : 0)
            ..rotateX(animation.value * widget.rotate.x)
            ..rotateY(animation.value * widget.rotate.y)
            ..rotateZ(animation.value * widget.rotate.x),
          child: listItem,
        );
      },
      animation: animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () {
            print('Tapped controller.isAnimating: ${controller.isAnimating}');
            if (controller.isAnimating) {
              print('Animation in progress, ignoring tap.');
              return; // Ignore if animation is still running
            }

            controller.forward(); // Start animation
          },
          onDoubleTapDown: (details) {
            return;
          },
          onDoubleTap: () {
            return;
          },
          child: entry.value,
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
