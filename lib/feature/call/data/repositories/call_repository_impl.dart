// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:callapp/feature/call/data/datasource/call_service.dart';
import 'package:callapp/feature/call/domain/repositories/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  final CallService callService;
  CallRepositoryImpl(this.callService);

  @override
  Future<void> endCall() {
    return callService.endCall();
  }

  @override
  Future<void> holdCall() {
    return callService.holdCall();
  }

  @override
  Future<void> resumeCall() {
    return callService.resumeCall();
  }

  @override
  Future<void> startCall() {
    return callService.startCall();
  }
}
