import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/dynamic_option.dart';

class QMSelectBox extends StatefulWidget {
  final List<DynamicOption> options;
  final String hintText;
  final Function(List<DynamicOption>) onSelectedOptionsChanged;

  const QMSelectBox({
    super.key,
    required this.options,
    required this.hintText,
    required this.onSelectedOptionsChanged,
  });

  @override
  State<QMSelectBox> createState() => _QMSelectBoxState();
}

class _QMSelectBoxState extends State<QMSelectBox> {
  List<DynamicOption> selectedOptions = [];
  String hint = '';

  void handleSelectedOption(DynamicOption? selectedOption) {
    setState(() {
      if (selectedOption != null) {
        selectedOptions.add(selectedOption);
        hint += '${selectedOption.label}, ';
      }
    });
    widget.onSelectedOptionsChanged(selectedOptions);
  }

  void clearSelectedOptions() {
    setState(() {
      selectedOptions.clear();
      hint = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TypeAheadField<DynamicOption?>(
          key: ValueKey(selectedOptions),
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => clearSelectedOptions(),
              ),
              hintText: hint,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(5),
              //   borderSide: BorderSide.none,
              // ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return widget.options
                .where((option) => option.label
                    .toLowerCase()
                    .contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, DynamicOption? suggestion) {
            return ListTile(
              title: Text(suggestion?.label ?? ''),
            );
          },
          onSuggestionSelected: handleSelectedOption,
        ),
        Wrap(
          spacing: 8.0,
          children: selectedOptions.map((option) {
            return Chip(
              label: Text(option.label),
              onDeleted: () {
                setState(() {
                  selectedOptions.remove(option);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
