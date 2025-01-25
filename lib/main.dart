import 'package:flutter/material.dart';
import 'package:flutter_workshop/flip_image.dart';
import 'package:flutter_workshop/flipping_switch.dart';
import 'package:flutter_workshop/global.dart';
import 'package:flutter_workshop/theme.dart';
import 'package:flutter_workshop/ticker_chart.dart';
import 'package:get/get.dart';

void main() {
  appInit();
}

appInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  // service
  Get.put(GlobalService());

  // start
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: GlobalService.to.isDarkMode ? AppTheme.dark : AppTheme.light,
      routes: {
        '/ticker': (context) => const TickerPage(),
      },
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => TickerPage(),
    //   ),
    // );
    Get.toNamed('/ticker');
  }

  void _changeTheme() {
    GlobalService.to.switchThemeModel();
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
      body: Padding(
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
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.all(16),
                  onPressed: _gotoNextPage,
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            SizedBox(
              height: 108,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeTheme,
        tooltip: 'change theme',
        child: Obx(
          () => Icon(
              GlobalService.to.isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
