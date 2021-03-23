import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
class PathUtil{
  static p.Context _context = p.Context();

  PathUtil._();

  /// 获取 应用程序的 data目录
  ///
  /// 如果在 runApp 之前调用，
  /// 则需要先执行 `WidgetsFlutterBinding.ensureInitialized();`
  static Future<String> getDataDir([String? path]) async {
    String dataDir = (await getApplicationDocumentsDirectory()).path;
    dataDir = _context.join(dataDir, path);
    return dataDir;
  }

}