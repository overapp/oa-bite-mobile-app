import 'package:bite/repository/interface/manager_interface.dart';
import 'package:bite/repository/manager/network_manager.dart';

// This class defines which manager should be instantiated during the execution of the "main" function, depending on the active mode. The possible modes are:
// "MockMode": Uses locally saved JSON files to populate data.
// "NetworkMode": The standard mode that performs calls to a backend to retrieve data.

class RepoManager {
  late Manager manager;

  RepoManager._internal();

  static final _singleton = RepoManager._internal();

  factory RepoManager() => _singleton;

  // Initialize the manager
  Future<void> setManager() async {
    manager = getManager();
  }

  Manager getManager() {
    return NetworkManager();
  }
}
