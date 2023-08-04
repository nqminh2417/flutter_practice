import 'package:flutter/material.dart';

import '../models/dynamic_option.dart';
import 'qm_modal_tag_search.dart';

class QMTagBox extends StatefulWidget {
  final String label;
  final List<DynamicOption> options;
  final Function(List<DynamicOption>) onSelectedOptionsChanged;

  const QMTagBox({
    super.key,
    required this.label,
    required this.options,
    required this.onSelectedOptionsChanged,
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
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
                onPressed: openTagSearch,
                child: const Text("Open Tag Search"))
          ],
        ),
        Wrap(
          runSpacing: -12,
          spacing: 4,
          children: _selectedOptions.map((tag) {
            return Chip(
              label: Text(tag.label),
              labelStyle: const TextStyle(
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onDeleted: () => _handleDeleteTag(tag),
            );
          }).toList(),
        ),
        Divider(
          color: Colors.amber.shade900,
          thickness: 0.75,
        ),
      ],
    );
  }
}
