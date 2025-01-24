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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
      backgroundColor: Colors.blueGrey,
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
                background: Color(0xFF333333),
                leftLabel: 'Free',
                rightLabel: 'Premium',
                color: Color(0xFFFFFF00),
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
