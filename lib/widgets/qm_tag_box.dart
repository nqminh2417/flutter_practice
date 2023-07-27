import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class QMTagBox extends StatefulWidget {
  final String label;
  final List<String> tags;
  final List<String> suggestions;

  const QMTagBox({
    super.key,
    required this.label,
    required this.tags,
    required this.suggestions,
  });

  @override
  State<QMTagBox> createState() => _QMTagBoxState();
}

class _QMTagBoxState extends State<QMTagBox> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _selectedTags.addAll(widget.tags);
  }

  void _handleAddTag(String tag) {
    setState(() {
      if (tag.isNotEmpty && !_selectedTags.contains(tag)) {
        _selectedTags.add(tag);
        _textEditingController.clear();
      }
    });
  }

  void _handleDeleteTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 8.0,
                children: _selectedTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () => _handleDeleteTag(tag),
                  );
                }).toList(),
              ),
              TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Add tag',
                    border: InputBorder.none,
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return widget.suggestions.where((suggestion) {
                    final lowerCasePattern = pattern.toLowerCase();
                    return suggestion
                            .toLowerCase()
                            .contains(lowerCasePattern) &&
                        !_selectedTags.contains(suggestion);
                  }).toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: _handleAddTag,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
