abstract class BluetoothPermissionState {
  BluetoothPermissionState();
}

class BluetoothPermissionInitial extends BluetoothPermissionState {
  BluetoothPermissionInitial();
}

class BluetoothPermissionLoading extends BluetoothPermissionState {
  BluetoothPermissionLoading();
}

class BluetoothPermissionSuccess extends BluetoothPermissionState {
  BluetoothPermissionSuccess();
}

class BluetoothPermissionError extends BluetoothPermissionState {
  final String message;

  BluetoothPermissionError(this.message);
}
