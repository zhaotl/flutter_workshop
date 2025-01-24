import 'package:flutter/material.dart';

class Ticker {
  final String name;
  final double highPrice;
  final double lowPrice;
  final double lastPrice;

  Ticker({
    required this.name,
    required this.highPrice,
    required this.lowPrice,
    required this.lastPrice,
  });
}

class TickerChart extends StatelessWidget {
  const TickerChart({super.key});

  // 模拟数据，实际应用中应该从外部传入
  List<Ticker> get _tickers => [
        Ticker(
          name: 'BTC/USDT',
          highPrice: 43250.50,
          lowPrice: 42800.30,
          lastPrice: 43100.80,
        ),
        Ticker(
          name: 'ETH/USDT',
          highPrice: 2280.40,
          lowPrice: 2250.10,
          lastPrice: 2270.60,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _tickers.length,
      itemBuilder: (context, index) {
        final ticker = _tickers[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    ticker.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('高:'),
                          Text(
                            '\$${ticker.highPrice.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('低:'),
                          Text(
                            '\$${ticker.lowPrice.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('现价:'),
                          Text(
                            '\$${ticker.lastPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
