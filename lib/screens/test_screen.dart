// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_practice/utils/string_utils.dart';
import 'package:flutter_practice/widgets/qm_tag_box.dart';
import 'package:flutter_practice/widgets/text_field/floating_label_text_field.dart';
import 'package:flutter_practice/widgets/text_field/ifta_label_text_field.dart';
import 'package:flutter_practice/widgets/qm_button.dart';
import 'package:flutter_practice/widgets/qm_select_box.dart';
import 'package:flutter_practice/widgets/text_field/stacked_label_text_field.dart';

import '../database/entertainment_db.dart';
import '../models/dynamic_option.dart';
import '../services/sqlite_service.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<DynamicOption> options = [
    DynamicOption('Johnny Depp', 'value1'),
    DynamicOption('Robert Downey Jr', 'value2'),
    DynamicOption('Tom Cruise', 'value3'),
    DynamicOption('Angelina Jolie', 'value4'),
    DynamicOption('Joaquin Phoenix', 'value5'),
    DynamicOption('Cate Blanchett', 'value6'),
    DynamicOption('Natalie Portman', 'value7'),
    DynamicOption('Ryan Reynolds', 'value8'),
    DynamicOption('Anne Hathaway', 'value9'),
    DynamicOption('Jennifer Lawrence', 'value10'),
    DynamicOption('Morgan Freeman', 'value11'),
    DynamicOption('Emma Stone', 'value12'),
    DynamicOption('Christian Bale', 'value13'),
    DynamicOption('Samuel L. Jackson', 'value14'),
    DynamicOption('Hugh Jackman', 'value15'),
    DynamicOption('Chris Evans', 'value16'),
    DynamicOption('Scarlett Johansson', 'value17'),
    DynamicOption('Nicole Kidman', 'value18'),
    DynamicOption('Benedict Cumberbatch', 'value19'),
    DynamicOption('Dwayne "The Rock" Johnson', 'value20'),
    // Add more options as needed
  ];

  List<String> fruits = ['Apple', 'Banana', 'Orange', 'Grapes', 'Mango'];

  void printSelectedOptions() {
    debugPrint('Selected Options:');
    for (var option in selectedOptions) {
      debugPrint('Label: ${option.label}, Value: ${option.value}');
    }
  }

  List<DynamicOption> selectedOptions = [];

  Future<bool> isDatabaseCreated() async {
    final db = await SQLiteService().database;
    return db.isOpen;
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _insertSampleVideos(BuildContext context) async {
    final entertaimentDB = EntertainmentDB();
    await entertaimentDB.insertSampleVideos();
    _showSnackbar(context, 'Sample videos inserted successfully');
  }

  Future<void> _showAllVideos(BuildContext context) async {
    final entertaimentDB = EntertainmentDB();
    final List<Map<String, dynamic>> videos =
        await entertaimentDB.getAllVideos();

    // Display the videos in some way (e.g., in a dialog or another widget)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('All Videos'),
          content: SingleChildScrollView(
            child: Column(
              children: videos.map((video) {
                return ListTile(
                  title: Text(video['title']),
                  subtitle: Text('Type: ${video['type']}'),
                  // Add more details if desired
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _resolutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 12,
              ),
              QMTagBox(
                  label: "Enterprise",
                  options: options,
                  onSelectedOptionsChanged: (List<DynamicOption> options) {}),
              //     Container(
              //   height: 150,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4.0),
              //     border: Border.all(color: Colors.grey),
              //   ),
              // ),
              const SizedBox(
                height: 12,
              ),
              FloatingLabelTextField(
                  label: "Actor", controller: _resolutionController),
              const SizedBox(
                height: 12,
              ),
              IFTALabelTextField(
                  label: "Title*", controller: _resolutionController),
              const SizedBox(
                height: 12,
              ),
              StackedLabelTextField(
                  labelText: "Hello*", controller: _resolutionController),
              ElevatedButton(
                onPressed: () async {
                  final isCreated = await isDatabaseCreated();
                  if (isCreated) {
                    await _showAllVideos(context);
                  } else {
                    _showSnackbar(context, 'Database does not exist');
                  }
                },
                child: const Text('Get All Videos'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final isCreated = await isDatabaseCreated();
                  if (isCreated) {
                    await _insertSampleVideos(context);
                  } else {
                    _showSnackbar(context, 'Database does not exist');
                  }
                },
                child: const Text('Insert Sample Videos'),
              ),
              const SizedBox(
                height: 12,
              ),
              Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Set the desired border radius
                ),
                label: Text("Awdwad"),
                deleteIcon: Icon(Icons.clear),
                onDeleted: () {},
              ),
              QMSelectBox(
                options: options,
                hintText: 'Search for an option...',
                onSelectedOptionsChanged: (List<DynamicOption> options) {
                  setState(() {
                    selectedOptions = options;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Call the function to print the selected options
                  printSelectedOptions();
                },
                child: const Text('Get Selected Options'),
              ),
              Chip(
                label: Text(StringUtils.generateRandomString()),
                onDeleted: () {},
              ),
              Text(StringUtils.generateRandomString()),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.amber),
              //     child: const DotBounce()),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.white70),
              //     child: const DotGrow()),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.white70),
              //     child: const DotFade()),
              // const SizedBox(
              //   height: 24,
              // ),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.white70),
              //     child: const ThreeBounce()),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.white70),
              //     child: const WaveIndicator()),
              // Container(
              //     height: 60,
              //     decoration: const BoxDecoration(color: Colors.white70),
              //     child: const FadingCircle()),
              SizedBox(
                // width: 200,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Icon(
                          Icons.home,
                          size: 24,
                        ),
                      ),
                      // SizedBox(width: 8),
                      Expanded(child: Text("Unsubscribe")),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              QMButton(
                width: 160,
                height: 40,
                text: "Unsubscribe",
                // leadingIcon: Icons.key,
                trailingIcon: Icons.lock,
                // borderRadius: 4,
                onPressed: () {},
                isDisabled: true,
              ),
              const SizedBox(
                height: 24,
              ),
              const ListTile(
                title: Text("Unsubscribe"),
                leading: Icon(Icons.quiz_outlined),
                trailing: Icon(Icons.qr_code),
                contentPadding: EdgeInsets.only(left: 16, right: 24),
              ),
              const SizedBox(
                height: 24,
              ),
              const ElevatedButton(
                onPressed: null, // Disable the button
                child: Text('Disabled Button'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
