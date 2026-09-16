import 'package:equatable/equatable.dart';

sealed class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object?> get props => [];
}

class CallStarted extends CallEvent {
  const CallStarted();
}

class CallConnected extends CallEvent {
  const CallConnected();
}

class CallEnded extends CallEvent {
  const CallEnded();
}

class CallFailed extends CallEvent {
  final String message;

  const CallFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class CallOnHold extends CallEvent {
  const CallOnHold();
}

class CallResume extends CallEvent {
  const CallResume();
}

class NetworkLost extends CallEvent {
  const NetworkLost();
}

class NetworkRestored extends CallEvent {
  const NetworkRestored();
}

class RetryCall extends CallEvent {
  const RetryCall();
}
