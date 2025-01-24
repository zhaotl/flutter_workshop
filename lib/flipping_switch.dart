import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlippingSwitch extends StatefulWidget {
  const FlippingSwitch({
    super.key,
    required this.background,
    required this.leftLabel,
    required this.rightLabel,
    required this.color,
    this.onChange,
  });
  final Color color;
  final Color background;
  final String leftLabel;
  final String rightLabel;
  final void Function(bool isLeftActive)? onChange;

  @override
  State<FlippingSwitch> createState() => _FlippingSwitchState();
}

class _FlippingSwitchState extends State<FlippingSwitch>
    with TickerProviderStateMixin {
  final double _maxTileAngle = math.pi / 6;
  late AnimationController _flipController;
  late AnimationController _tileController;
  late Animation _tileAnimation;
  double _directionMultiplier = 1;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _jumpToMode(true);

    _tileController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 1500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _tileController.reverse();
        }
      });

    _tileAnimation = CurvedAnimation(
        parent: _tileController, curve: Curves.elasticOut.flipped);
  }

  @override
  void dispose() {
    _tileController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _jumpToMode(bool leftEnabled) {
    _flipController.value = leftEnabled ? 1.0 : 0.0;
  }

  void _flipSwitch() {
    if (_flipController.isCompleted) {
      _directionMultiplier = -1;
      _tileController.forward();
      _flipController.reverse();
      widget.onChange?.call(true);
    } else {
      _directionMultiplier = 1;
      _tileController.forward();
      _flipController.forward();
      widget.onChange?.call(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tileAnimation,
      builder: (context, tabs) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
                _tileAnimation.value * _maxTileAngle * _directionMultiplier),
          alignment: FractionalOffset(0.5, 1.0),
          child: tabs,
        );
      },
      child: Stack(
        children: [
          _buildTabsBackground(),
          AnimatedBuilder(
              animation: _flipController,
              builder: (context, child) {
                return _buildFlippingSwitch(_flipController.value * math.pi);
              }),
        ],
      ),
    );
  }

  Widget _buildFlippingSwitch(double angle) {
    final isLeft = angle > (math.pi / 2);
    final transformAngle = isLeft ? angle - math.pi : angle;
    return Positioned(
      top: 0,
      bottom: 0,
      right: isLeft ? null : 0,
      left: isLeft ? 0 : null,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(transformAngle),
        alignment:
            isLeft ? FractionalOffset(1.0, 1.0) : FractionalOffset(0.0, 1.0),
        child: Container(
          width: 125,
          height: 64,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.only(
              topRight: isLeft ? Radius.zero : Radius.circular(32),
              bottomRight: isLeft ? Radius.zero : Radius.circular(32),
              topLeft: isLeft ? Radius.circular(32) : Radius.zero,
              bottomLeft: isLeft ? Radius.circular(32) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              isLeft ? widget.leftLabel : widget.rightLabel,
              style: TextStyle(
                color: widget.background,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabsBackground() {
    return GestureDetector(
      onTap: _flipSwitch,
      child: Container(
        width: 250,
        height: 64,
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(width: 5, color: widget.color),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  widget.leftLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.rightLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
