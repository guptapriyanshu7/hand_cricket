import 'package:flutter/material.dart';

const mapAssetsToIndex = {
  1: 'assets/one.png',
  2: 'assets/two.png',
  3: 'assets/three.png',
  4: 'assets/four.png',
  5: 'assets/five.png',
  6: 'assets/six.png',
};

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.count(
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 40,
        children: List.generate(6, (index) {
          return Center(
            child: Image.asset(mapAssetsToIndex[index + 1]!, fit: BoxFit.cover),
          );
        }),
      ),
    );
  }
}
