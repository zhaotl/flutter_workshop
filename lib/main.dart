import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop/flip_image.dart';
import 'package:flutter_workshop/flipping_switch.dart';
import 'package:flutter_workshop/ticker_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xFF065808),
          primaryContainer: Color(0xFF9EE2A0),
          primaryLightRef: Color(0xFF065808),
          secondary: Color(0xFF365B37),
          secondaryContainer: Color(0xFFAFBDAF),
          secondaryLightRef: Color(0xFF365B37),
          tertiary: Color(0xFF2C7E2E),
          tertiaryContainer: Color(0xFFB9E6B9),
          tertiaryLightRef: Color(0xFF2C7E2E),
          appBarColor: Color(0xFFB9E6B9),
          error: Color(0xFFB00020),
          errorContainer: Color(0xFFFCD9DF),
        ),
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          useM2StyleDividerInM3: true,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          alignedDropdown: true,
          navigationRailUseIndicator: true,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xFF629F80),
          primaryContainer: Color(0xFF284134),
          primaryLightRef: Color(0xFF065808),
          secondary: Color(0xFF81B39A),
          secondaryContainer: Color(0xFF4D6B5C),
          secondaryLightRef: Color(0xFF365B37),
          tertiary: Color(0xFF88C5A6),
          tertiaryContainer: Color(0xFF356C51),
          tertiaryLightRef: Color(0xFF2C7E2E),
          appBarColor: Color(0xFF356C51),
          error: Color(0xFFCF6679),
          errorContainer: Color(0xFFB1384E),
        ),
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnColors: true,
          useM2StyleDividerInM3: true,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          alignedDropdown: true,
          navigationRailUseIndicator: true,
          navigationRailLabelType: NavigationRailLabelType.all,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  String _assetPath = 'images/cats1.png';

  void _gotoNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Ticker Chart'),
          ),
          body: TickerChart(),
        ),
      ),
    );
  }

  void changeAssetPath(bool isLeftActive) {
    setState(() {
      _assetPath = isLeftActive ? 'images/cats2.png' : 'images/cats1.png';
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlippingSwitch(
                color: Theme.of(context).primaryColor, // Color(0xFF333333),
                leftLabel: 'Flower',
                rightLabel: 'Cake',
                background: Theme.of(context).colorScheme.primaryContainer,
                onChange: (isLeftActive) {
                  changeAssetPath(isLeftActive);
                },
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: MyFlipImage(assetPath: _assetPath),
              ),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoNextPage,
        tooltip: 'goto Next',
        child: const Icon(Icons.arrow_forward_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
