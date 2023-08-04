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
  TextEditingController _searchController = TextEditingController();
  List<DynamicOption> _selectedOptions = [];
  List<DynamicOption> _selectingOptions = [];
  List<DynamicOption> _suggestedOptions = [];

  void _onSearchChanged(String query) {
    setState(() {
      _suggestedOptions = widget.options.where((option) {
        return option.label.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onOptionSelected(DynamicOption selectedOption) {
    setState(() {
      _selectedOptions.add(selectedOption);
      _searchController.clear();
      _suggestedOptions.clear();
    });
  }

  void _handleAddTag(String tag) {
    setState(() {
      // if (tag.isNotEmpty && !_selectedTags.contains(tag)) {
      //   _selectedTags.add(tag);
      //   _textEditingController.clear();
      // }
    });
  }

  void _handleDeleteTag(DynamicOption deletedOption) {
    setState(() {
      _selectedOptions.remove(deletedOption);
    });
  }

  void openTagSearch() async {
    final List<DynamicOption>? selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QMModalTagSearch(options: widget.options),
      ),
    );

    setState(() {
      _selectedOptions = selected ?? [];
    });
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
                // fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
                onPressed: openTagSearch, child: const Text("Open Tag Search"))
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

  void showFullScreenModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand:
              false, // Set this to true if you want the sheet to expand fully when dragged upwards.
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                controller:
                    scrollController, // Set the scroll controller for the ListView.
                itemCount:
                    100, // Replace this with the actual number of items you want to display.
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
 //               Navigator.of(context).pop();
// Column(
//             children: [
//               const ListTile(
//                 leading: Icon(Icons.loyalty),
//                 title: Text("Add tags"),
//                 trailing: Icon(Icons.add_circle),
//                 ),
//               Wrap(
//                 spacing: 8.0,
//                 children: _selectedOptions.map((tag) {
//                   return Chip(
//                     label: Text(tag.label),
//                     onDeleted: () => _handleDeleteTag(tag),
//                   );
//                 }).toList(),
//               ),
//               TextField(
//                 controller: _searchController,
//                 onChanged: _onSearchChanged,
//                 decoration: const InputDecoration(
//                   labelText: 'Search options',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),