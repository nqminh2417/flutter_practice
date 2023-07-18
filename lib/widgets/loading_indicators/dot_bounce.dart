import 'package:flutter/widgets.dart';

import '../../helpers/delay_tween.dart';

/// https://www.boltuix.com/2023/03/how-to-create-different-types-of.html
class DotBounce extends StatefulWidget {
  final Color? color;
  final AnimationController? controller;
  final int count;
  final Duration duration;
  final IndexedWidgetBuilder? itemBuilder;
  final double size;

  const DotBounce({
    super.key,
    this.color = const Color(0xff456322),
    this.size = 24,
    this.count = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 300),
    this.controller,
  });

  @override
  State<DotBounce> createState() => _DotBounceState();
}

class _DotBounceState extends State<DotBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(
            vsync: this,
            duration: Duration(
                milliseconds: widget.count * widget.duration.inMilliseconds)))
      ..repeat();
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 3.2, widget.size * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.count, (i) {
            return SlideTransition(
              position: DelayTweenOffset(
                      begin: const Offset(0, 0.5),
                      end: const Offset(0, -0.5),
                      delay: i * 0.2)
                  .animate(_controller),
              child: SizedBox.fromSize(
                  size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }
}
