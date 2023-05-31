import 'package:flutter/material.dart';
import 'package:flutter_practice/models/progress_summertime_saga.dart';

class ProgressBar extends StatelessWidget {
  final double height;
  final Color completeColor;
  final Color workingColor;
  final Color totalColor;
  final String title;
  final int complete;
  final int working;
  final int total;
  final Percent percent;

  const ProgressBar(
      {super.key,
      required this.height,
      required this.completeColor,
      required this.workingColor,
      required this.totalColor,
      required this.title,
      required this.complete,
      required this.working,
      required this.total,
      required this.percent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentwidth = constraints.maxWidth;
        return Container(
          width: parentwidth,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color(0xB0B2B500),
                width: 0.5,
                style: BorderStyle.solid),
          ),
          child: Stack(
            children: [
              Container(
                width: parentwidth,
                decoration: BoxDecoration(
                  color: totalColor,
                ),
              ),
              Container(
                width: total == 0
                    ? parentwidth
                    : (((complete + working) / total) * parentwidth),
                decoration: BoxDecoration(
                  color: workingColor,
                ),
              ),
              Container(
                width: total == 0
                    ? parentwidth
                    : ((complete / total) * parentwidth),
                decoration: BoxDecoration(
                  color: completeColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '[$complete/$total] ${percent.completed}%',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
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
