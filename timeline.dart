import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderTimelinePage extends StatelessWidget {
  final int currentStep = 3; // Change this dynamically to reflect current progress

  final List<String> steps = [
    'Order Placed',
    'Packed',
    'Shipped',
    'Out for Delivery',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Status"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: index == 0,
            isLast: index == steps.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 20,
              color: index <= currentStep ? Colors.green : Colors.grey,
              indicator: index <= currentStep
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            beforeLineStyle: LineStyle(
              color: index <= currentStep ? Colors.green : Colors.grey,
              thickness: 4,
            ),
            endChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                steps[index],
                style: TextStyle(
                  color: index <= currentStep ? Colors.white : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
