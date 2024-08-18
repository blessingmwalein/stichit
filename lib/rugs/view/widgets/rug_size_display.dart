import 'package:flutter/material.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';

class RugSizesDisplay extends StatelessWidget {
  final List<RugSizes> rugSizes;

  const RugSizesDisplay({
    super.key,
    required this.rugSizes,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        mainAxisSpacing: 10.0, // Spacing between rows
        crossAxisSpacing: 10.0, // Spacing between columns
        childAspectRatio: 1.0, // Aspect ratio of the items
      ),
      shrinkWrap: true, // Allows GridView to fit within available space
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      itemCount: rugSizes.length,
      itemBuilder: (context, index) {
        return RugSizeDisplay(rugSize: rugSizes[index]);
      },
    );
  }
}

class RugSizeDisplay extends StatelessWidget {
  final RugSizes rugSize;

  const RugSizeDisplay({
    super.key,
    required this.rugSize,
  });

  @override
  Widget build(BuildContext context) {
    // Scale factor to fit rug sizes within a max size (e.g., 200x200 pixels)
    const double maxSize = 200.0;
    final double scaleFactor = maxSize /
        (rugSize.length > rugSize.width ? rugSize.length : rugSize.width);

    final double displayLength = rugSize.length * scaleFactor;
    final double displayWidth = rugSize.width * scaleFactor;

    return Stack(
      children: [
        Container(
          width: displayWidth,
          height: displayLength,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/rug.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            '\$${rugSize.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.black,
            ),
          ),
        ),
        Positioned(
          left: 4,
          top: displayLength / 2 - 10,
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              '${rugSize.length.toStringAsFixed(2)} cm',
              style: const TextStyle(
                fontSize: 14,
                color: CustomColors.black,
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: displayWidth / 2 - 20,
          child: Text(
            '${rugSize.width.toStringAsFixed(2)} cm',
            style: const TextStyle(
              fontSize: 14,
              color: CustomColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
