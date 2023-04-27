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

  static Future<void> put(UserData user) async {
    var isar = await Database.isar();
    await isar!.writeTxn(() async {
      await Database.database().then((db) => db!.put(user));
    });
  }

  static Future<void> putAll(List<UserData> userList) async {
    var isar = await Database.isar();
    await isar!.writeTxn(() => isar.userDatas.putAll(userList));
  }
}
