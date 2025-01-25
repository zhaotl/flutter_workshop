import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipImage extends StatelessWidget {
  const FlipImage({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TabBarView(controller: tabController, children: [
        MyFlipImage(assetPath: 'images/cats1.png'),
        MyFlipImage(assetPath: 'images/cats2.png'),
      ]),
    );
  }
}

class MyFlipImage extends StatefulWidget {
  const MyFlipImage({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  State<MyFlipImage> createState() => _MyFlipImageState();
}

class _MyFlipImageState extends State<MyFlipImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late String currentImagePath;
  late String _image1;
  late String _image2;
  late final Curve _curve = Curves.elasticOut;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _image1 = widget.assetPath;
    currentImagePath = widget.assetPath;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )
      ..addListener(updateRotation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onRotationEnd();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyFlipImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.assetPath != oldWidget.assetPath) {
      _immediatelyCurrentAnimation();
      _image2 = widget.assetPath;
      _flipCard();
    }
  }

  void updateRotation() {
    setState(() {
      _rotation = _curve.transform(_animationController.value) * math.pi;
      if (currentImagePath == _image1 && _rotation > math.pi / 2) {
        // the first image has crossed over the second image
        currentImagePath = _image2;
      } else if (currentImagePath == _image2 && _rotation < math.pi / 2) {
        // the second image is visible, but we've swung back to the first image
        currentImagePath = _image1;
      } else if (currentImagePath == _image2) {
        // Adjust rotation so that if we've shoing the next image, we don't
        // horizontally invert it. In other words, instead of showing the "back" of the next image
        // we show the "front" of the next image.
        _rotation = _rotation - math.pi;
      }
    });
  }

  void _flipCard() {
    currentImagePath = _image1;
    _animationController.forward(from: 0.0);
  }

  void onRotationEnd() {
    setState(() {
      _animationController.value = 0;
      currentImagePath = _image2;
      _image1 = _image2;
    });
  }

  void _immediatelyCurrentAnimation() {
    if (_animationController.isAnimating) {
      _animationController.stop();
      onRotationEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotation),
        alignment: FractionalOffset.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: IntrinsicHeight(
            child: Image.asset(
              currentImagePath,
            ),
          ),
        ),
      ),
    );
  }
}
