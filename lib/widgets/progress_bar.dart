import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double height;
  // final Color completeColor;
  // final Color workingColor;
  // final Color remainingColor;
  final String title;
  final int complete;
  final int working;
  final int total;

  const ProgressBar({
    super.key,
    required this.height,
    // required this.completeColor,
    // required this.workingColor,
    // required this.remainingColor,
    required this.title,
    required this.complete,
    required this.working,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentwidth = constraints.maxWidth;
        return Container(
          width: parentwidth,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            children: [
              Container(
                width: parentwidth,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
              ),
              Container(
                width: total == 0
                    ? parentwidth
                    : (((complete + working) / total) * parentwidth),
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
              ),
              Container(
                width: total == 0
                    ? parentwidth
                    : ((complete / total) * parentwidth),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '[$complete/$total]',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
