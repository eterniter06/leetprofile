import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

const String database = 'users.db';

class Database {
  Database._();

  static Isar? _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserDataSchema],
      directory: dir.path,
    );
  }

  static Future<IsarCollection<UserData>?> database() async {
    if (_isar == null) init();
    return _isar?.collection<UserData>();
  }

  static Future<Isar?> isar() async {
    if (_isar == null) init();
    return _isar;
  }

  static Future<int> size() async {
    if (_isar == null) init();
    return _isar!.collection<UserData>().count();
  }
}
