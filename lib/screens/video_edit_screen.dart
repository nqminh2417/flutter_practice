import 'package:flutter/material.dart';

import '../widgets/text_field/stacked_label_text_field.dart';

class VideoEditScreen extends StatefulWidget {
  const VideoEditScreen({super.key});

  @override
  State<VideoEditScreen> createState() => _VideoEditScreenState();
}

class _VideoEditScreenState extends State<VideoEditScreen> {
  // Define variables and controllers to handle the video information
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // Implement the UI for adding and editing video information
            children: [
              StackedLabelTextField(
                labelText: 'Title',
                controller: _titleController,
                keyboardType: TextInputType.text,
              ),
              StackedLabelTextField(
                labelText: 'Release Date',
                controller: _releaseDateController,
                keyboardType: TextInputType.text,
              ),
              StackedLabelTextField(
                labelText: 'Type',
                controller: _typeController,
                keyboardType: TextInputType.text,
              ),
              StackedLabelTextField(
                labelText: 'Resolution',
                controller: _resolutionController,
                keyboardType: TextInputType.text,
              ),
              // Add more fields as needed
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to save or update video information
                  // For adding a new video, you can use the _titleController.text,
                  // _releaseDateController.text, etc. to get the user inputs.
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
