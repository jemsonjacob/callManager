abstract interface class CallRepository {
  Future<void> startCall();

  Future<void> endCall();

  Future<void> holdCall();

  Future<void> resumeCall();
}
