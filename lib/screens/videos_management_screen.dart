import 'package:flutter/material.dart';
import 'package:flutter_practice/database/entertainment_db.dart';
import 'package:flutter_practice/screens/video_edit_screen.dart';

class VidMgmtScreen extends StatefulWidget {
  const VidMgmtScreen({super.key});

  @override
  State<VidMgmtScreen> createState() => _VidMgmtScreenState();
}

class _VidMgmtScreenState extends State<VidMgmtScreen> {
  List<Map<String, dynamic>> allVideos =
      []; // List to store all videos from the database
  List<Map<String, dynamic>> filteredVideos =
      []; // List to store filtered videos
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos(); // Fetch videos from the database when the screen is loaded
  }

  Future<void> _fetchVideos() async {
    final pographyDB = EntertainmentDB();
    final fetchedVideos = await pographyDB.getAllVideos();
    setState(() {
      allVideos = fetchedVideos;
      filteredVideos = allVideos; // Initialize filteredVideos with all videos
    });
  }

  void _filterVideos(String query) {
    setState(() {
      filteredVideos = allVideos
          .where((video) => video['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchIconClicked() {
    setState(() {
      _isSearching = true;
    });
  }

  void _onCancelClicked() {
    setState(() {
      _isSearching = false;
      _clearSearch();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus(); // Close the keyboard
    _filterVideos(''); // Reset the filter to show all videos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade300,
        title: _isSearching
            ? SizedBox(
                height: 36,
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterVideos,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    hintText: 'Search Videos',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: _clearSearch,
                            icon: const Icon(Icons.cancel),
                            highlightColor: Colors.transparent,
                          )
                        : null,
                    // hintStyle: const TextStyle(color: Colors.white),
                    fillColor:
                        Colors.grey[200], // Set the background color to gray
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                        gapPadding: 0),
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'Videos Management Screen',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Neonsign'),
                ),
              ),
        actions: [
          _isSearching
              ? TextButton(
                  onPressed: _onCancelClicked,
                  onLongPress: null,
                  autofocus: true,
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : IconButton(
                  onPressed: _onSearchIconClicked,
                  icon: const Icon(Icons.search),
                  highlightColor: Colors.transparent,
                )
        ],
      ),
      body: ListView.builder(
        itemCount: filteredVideos.length,
        itemBuilder: (context, index) {
          final video = filteredVideos[index];
          return ListTile(
            title: Text(video['title']),
            subtitle: Text('Type: ${video['type']}'),
            // Add more details as needed
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VideoEditScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
