import 'package:equatable/equatable.dart';

enum CallStatus {
  idle,
  connecting,
  connected,
  onHold,
  reconnecting,
  ended,
  failed,
}

class CallState extends Equatable {
  final CallStatus status;
  final String? errorMessage;

  const CallState({this.status = CallStatus.idle, this.errorMessage});

  CallState copyWith({
    CallStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CallState(
      status: status ?? this.status,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
