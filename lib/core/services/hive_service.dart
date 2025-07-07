import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  HiveService._();

  static bool _isInitialized = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      _isInitialized = true;
    }
  }

  static Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  Future openBox(Box? firstTimeBox) async {}
}
