import 'package:flutter/material.dart';

import '../database/entertainment_db.dart';
import '../widgets/text_field/stacked_label_text_field.dart';

class VideoEditScreen extends StatefulWidget {
  final String videoId;

  const VideoEditScreen({super.key, required this.videoId});

  @override
  State<VideoEditScreen> createState() => _VideoEditScreenState();
}

class _VideoEditScreenState extends State<VideoEditScreen> {
  // Define variables and controllers to handle the video information
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();

  late bool readOnly = false;

  @override
  void initState() {
    super.initState();
    // Check if videoId is equal to "0"
    if (widget.videoId != "0") {
      readOnly = true;
      _fetchVideo(); // Fetch videos from the database when the screen is loaded and videoId is not equal to "0"
    }
  }

  Future<void> _fetchVideo() async {
    final entertainmentDB = EntertainmentDB();
    final Map<String, dynamic>? fetchedVideo =
        await entertainmentDB.getVideoById(widget.videoId);
    debugPrint(fetchedVideo.toString());
    _titleController.text = fetchedVideo?['title'];
    _releaseDateController.text = fetchedVideo?['releaseDate'];
    _typeController.text = fetchedVideo?['type'];
    _resolutionController.text = fetchedVideo?['resolution'];
  }

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
                readOnly: readOnly,
              ),
              StackedLabelTextField(
                labelText: 'Release Date',
                controller: _releaseDateController,
                keyboardType: TextInputType.text,
                readOnly: readOnly,
              ),
              StackedLabelTextField(
                labelText: 'Type',
                controller: _typeController,
                keyboardType: TextInputType.text,
                readOnly: readOnly,
              ),
              StackedLabelTextField(
                labelText: 'Resolution',
                controller: _resolutionController,
                keyboardType: TextInputType.text,
                readOnly: readOnly,
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
