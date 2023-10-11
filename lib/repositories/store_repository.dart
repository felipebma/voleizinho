import 'package:objectbox/objectbox.dart' as objectbox;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:voleizinho/objectbox.g.dart';

/// Repository to initialize the ObjectBox Store object
class StoreRepository {
  late final objectbox.Store _store;

  /// Initializes the ObjectBox Store object.
  Future<void> initStore() async {
    final appDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    _store = Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirectory.path, 'voleizinho-db'),
    );

    return;
  }

  /// Getter for the store object.
  objectbox.Store get store => _store;
}
