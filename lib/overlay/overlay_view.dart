import 'dart:math';

import 'package:flutter/material.dart';

class OverlayView extends StatefulWidget {
  const OverlayView({super.key});

  @override
  State<OverlayView> createState() => _OverlayViewState();
}

class _OverlayViewState extends State<OverlayView> {
  OverlayState? _overlayState;
  final List<OverlayEntry> _overlayEntries = [];

  @override
  void initState() {
    super.initState();
    _overlayState = Overlay.of(context);
  }

  @override
  void dispose() {
    _overlayState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Overlay View'),
      ),
      body: const Center(
        child: Text('Overlay View'),
      ),
      floatingActionButton: _buildOverlayButton(),
    );
  }

  void showRandomOverlay() {
    final bgColor = Color.fromARGB(255, 1 + Random().nextInt(254),
        1 + Random().nextInt(254), 1 + Random().nextInt(254));

    final screenWidth = MediaQuery.of(context).size.width;
    final randomHeight =
        MediaQuery.of(context).size.height * Random().nextDouble();

    OverlayEntry? overlayEnry;
    overlayEnry = OverlayEntry(
      builder: (context) => Positioned(
        top: randomHeight,
        left: 0,
        child: Material(
          color: bgColor,
          child: InkWell(
            onTap: () {
              overlayEnry?.remove();
              _overlayEntries.remove(overlayEnry);
            },
            child: SizedBox(
              width: screenWidth,
              height: 100,
              child: Center(
                child: Text(
                  '这是一个 Overlay ${Random().nextInt(100)} 层，点击关闭',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    _overlayState?.insert(overlayEnry);
    _overlayEntries.add(overlayEnry);
  }

  Widget _buildOverlayButton() {
    return FloatingActionButton(
      onPressed: showRandomOverlay,
      child: const Icon(Icons.add),
    );
  }
}
