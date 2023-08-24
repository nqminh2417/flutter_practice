import '../services/sqlite_service.dart';

class EntertainmentDB {
  final SQLiteService _sqLiteService = SQLiteService();

  Future<void> insertVideo(Map<String, dynamic> videoData) async {
    final db = await _sqLiteService.database;
    await db.insert('Videos', videoData);
  }

  Future<List<Map<String, dynamic>>> getAllVideos() async {
    final db = await _sqLiteService.database;
    return await db.query('Videos');
  }

  Future<Map<String, dynamic>?> getVideoById(String videoId) async {
    final db = await _sqLiteService.database;
    final List<Map<String, dynamic>> result = await db.query(
      'Videos',
      where: 'id = ?',
      whereArgs: [videoId],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null; // Video with the specified ID not found
    }
  }

  Future<void> updateVideo(int id, Map<String, dynamic> videoData) async {
    final db = await _sqLiteService.database;
    await db.update('Videos', videoData, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteVideo(int id) async {
    final db = await _sqLiteService.database;
    await db.delete('Videos', where: 'id = ?', whereArgs: [id]);
  }

  // Similar CRUD operations for Actors and Studios tables
  // Insert, Get all, Update, Delete

  Future<void> insertSampleVideos() async {
    final db = await _sqLiteService.database;
    await db.transaction((txn) async {
      for (var i = 1; i <= 5; i++) {
        await txn.insert(
          'Videos',
          {
            'id': '$i',
            'title': 'Sample Video $i',
            'releaseDate': '2023-07-20',
            'isVR': 0,
            'type': 'Sample Type',
            'resolution': 'Full HD',
          },
        );
      }
    });
  }
}
