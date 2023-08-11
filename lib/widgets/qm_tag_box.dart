import 'package:flutter/material.dart';

import '../models/dynamic_option.dart';
import 'qm_modal_tag_search.dart';

class QMTagBox extends StatefulWidget {
  final String label;
  final List<DynamicOption> options;
  final Function(List<DynamicOption>) onSelectedOptionsChanged;
  final Color chipBackgroundColor;
  final Color chipDeleteIconColor;
  final TextStyle labelStyle;
  final TextStyle chipLabelStyle;
  final double chipBorderRadius;
  final String openTagSearchText;
  final TextStyle openTagSearchTextStyle;
  final double spacing;
  final double runSpacing;
  final bool showDivider;
  final double dividerHeight;
  final double dividerThickness;
  final Color dividerColor;
  final double dividerIndent;
  final double dividerEndIndent;

  const QMTagBox({
    super.key,
    required this.label,
    required this.options,
    required this.onSelectedOptionsChanged,
    this.chipBackgroundColor = const Color(0xffdcdcdc),
    this.chipDeleteIconColor = Colors.black, //const Color(0xff1c1c1c),
    this.labelStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    this.chipLabelStyle = const TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    this.chipBorderRadius = 4,
    this.openTagSearchText = "Open Tag Search",
    this.openTagSearchTextStyle = const TextStyle(),
    this.spacing = 4,
    this.runSpacing = -12,
    this.showDivider = true,
    this.dividerHeight = 4,
    this.dividerThickness = 0.75,
    this.dividerColor = Colors.black,
    this.dividerIndent = 0,
    this.dividerEndIndent = 0,
  });

  @override
  State<QMTagBox> createState() => _QMTagBoxState();
}

class _QMTagBoxState extends State<QMTagBox> {
  List<DynamicOption> _selectedOptions = [];

  void _handleDeleteTag(DynamicOption deletedOption) {
    setState(() {
      _selectedOptions.remove(deletedOption);
    });
  }

  void openTagSearch() async {
    final List<DynamicOption>? selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QMModalTagSearch(
          options: widget.options,
          selectedOptions: _selectedOptions,
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedOptions = selected;
      });
      widget.onSelectedOptionsChanged(_selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: widget.labelStyle,
            ),
            TextButton(
              onPressed: openTagSearch,
              child: Text(
                widget.openTagSearchText,
                style: widget.openTagSearchTextStyle,
              ),
            ),
          ],
        ),
        Wrap(
          runSpacing: widget.runSpacing,
          spacing: widget.spacing,
          children: _selectedOptions.map((tag) {
            return Chip(
              label: Text(tag.label),
              labelStyle: widget.chipLabelStyle,
              backgroundColor: widget.chipBackgroundColor,
              deleteIconColor: widget.chipDeleteIconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.chipBorderRadius),
              ),
              onDeleted: () => _handleDeleteTag(tag),
            );
          }).toList(),
        ),
        if (widget.showDivider)
          Divider(
            height: widget.dividerHeight,
            thickness: widget.dividerThickness,
            color: widget.dividerColor,
            indent: widget.dividerIndent,
            endIndent: widget.dividerEndIndent,
          ),
      ],
    );
  }
}
