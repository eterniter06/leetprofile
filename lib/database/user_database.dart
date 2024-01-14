import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../dataclass/user_class/userdata.dart';

const String database = 'users.db';

class UserDatabase {
  UserDatabase._();

  static Isar? _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserDataSchema],
      directory: dir.path,
    );
  }

  static Future<IsarCollection<UserData>?> database() async {
    if (_isar == null) await init();
    return _isar?.collection<UserData>();
  }

  static Future<Isar?> isar() async {
    if (_isar == null) await init();
    return _isar;
  }

  static Future<int> size() async {
    if (_isar == null) await init();
    return _isar!.collection<UserData>().count();
  }

  static Future<void> put(UserData user) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() async {
      await UserDatabase.database().then((db) => db!.put(user));
    });
  }

  static Future<void> putAll(List<UserData> userList) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() => isar.userDatas.putAll(userList));
  }

  static Future<void> delete(UserData user) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() async => await isar.userDatas.delete(user.isarId));
  }

  static Future<void> deleteAll() async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() async => await isar.userDatas.clear());
  }
}
