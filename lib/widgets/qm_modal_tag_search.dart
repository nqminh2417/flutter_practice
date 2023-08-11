import 'package:flutter/material.dart';

import '../models/dynamic_option.dart';

class QMModalTagSearch extends StatefulWidget {
  final List<DynamicOption> options;
  final List<DynamicOption> selectedOptions;

  const QMModalTagSearch(
      {super.key, required this.options, required this.selectedOptions});

  @override
  State<QMModalTagSearch> createState() => _QMModalTagSearchState();
}

class _QMModalTagSearchState extends State<QMModalTagSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<DynamicOption> filteredOptions = [];

  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredOptions = widget.options.where((option) {
        return option.label.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    // Separating selected and unselected options
    final selectedSet = widget.selectedOptions.toSet();
    final unselectedOptions = filteredOptions
        .where((option) => !selectedSet.contains(option))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context, widget.selectedOptions);
          },
        ),
        title: const Text('Screen A'),
        actions: [
          TextButton(
            child: const Text(
              'Apply',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context, widget.selectedOptions);
            },
          ),
          TextButton(
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                widget.selectedOptions.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search for actors',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.cancel),
                        highlightColor: Colors.transparent,
                      )
                    : null,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    widget.selectedOptions.length + unselectedOptions.length,
                // separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  if (index < widget.selectedOptions.length) {
                    // Display selected options
                    final option = widget.selectedOptions[index];
                    return Center(
                      child: ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -2),
                        title: Text(
                          option.label,
                          style: const TextStyle(fontSize: 14),
                        ),
                        leading: const Icon(Icons.check_box, color: Colors.green),
                        onTap: () {
                          setState(() {
                            widget.selectedOptions.remove(option);
                          });
                        },
                      ),
                    );
                  } else {
                    // Display unselected options
                    final option =
                        unselectedOptions[index - widget.selectedOptions.length];
                    return Center(
                      child: ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -2),
                        title: Text(
                          option.label,
                          style: const TextStyle(fontSize: 14),
                        ),
                        leading: const Icon(Icons.check_box_outline_blank),
                        onTap: () {
                          setState(() {
                            widget.selectedOptions.add(option);
                          });
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
