import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
