import 'package:flutter/material.dart';

import '../models/dynamic_option.dart';

class QMModalTagSearch extends StatefulWidget {
  final List<DynamicOption> options;

  const QMModalTagSearch({super.key, required this.options});

  @override
  State<QMModalTagSearch> createState() => _QMModalTagSearchState();
}

class _QMModalTagSearchState extends State<QMModalTagSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<DynamicOption> filteredOptions = [];
  List<DynamicOption> selectedOptions = [];

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

  void _handleDeleteTag(DynamicOption deletedOption) {
    setState(() {
      selectedOptions.remove(deletedOption);
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
    final selectedSet = selectedOptions.toSet();
    final unselectedOptions = filteredOptions.where((option) => !selectedSet.contains(option)).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context, selectedOptions);
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
              Navigator.pop(context, selectedOptions);
            },
          ),
          TextButton(
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                selectedOptions = [];
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
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: selectedOptions.length + unselectedOptions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                if (index < selectedOptions.length) {
                  // Display selected options
                  final option = selectedOptions[index];
                  return Center(
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      title: Text(option.label),
                      leading: const Icon(Icons.check_box, color: Colors.green),
                      onTap: () {
                        setState(() {
                          selectedOptions.remove(option);
                        });
                      },
                    ),
                  );
                } else {
                  // Display unselected options
                  final option = unselectedOptions[index - selectedOptions.length];
                  return Center(
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      title: Text(option.label),
                      leading: const Icon(Icons.check_box_outline_blank),
                      onTap: () {
                        setState(() {
                          selectedOptions.add(option);
                        });
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Expanded(
//             child: ListView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: filteredOptions.length,
//               itemBuilder: (context, index) {
//                 final option = filteredOptions[index];
//                 final isSelected = selectedOptions.contains(option);
//                 return ListTile(
//                   dense: true,
//                   visualDensity: const VisualDensity(vertical: -3),
//                   title: Text(option.label),
//                   leading: isSelected
//                       ? const Icon(Icons.check_box, color: Colors.green)
//                       : const Icon(Icons.check_box_outline_blank),
//                   onTap: () {
//                     setState(() {
//                       if (isSelected) {
//                         selectedOptions.remove(option);
//                       } else {
//                         selectedOptions.add(option);
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//           ),