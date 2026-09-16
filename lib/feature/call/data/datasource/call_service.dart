import 'dart:async';

class CallService {
  Timer? _connectionTimer;

  Future<void> startCall() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> endCall() async {
    _connectionTimer?.cancel();
    _connectionTimer = null;
  }

  Future<void> holdCall() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> resumeCall() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void dispose() {
    _connectionTimer?.cancel();
    _connectionTimer = null;
  }
}
