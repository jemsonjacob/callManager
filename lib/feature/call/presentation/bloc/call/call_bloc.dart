// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:callapp/feature/call/domain/repositories/call_repository.dart';

import 'call_event.dart';
import 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository repository;

  CallBloc(this.repository) : super(const CallState()) {
    on<CallStarted>(_onStartCall);
    on<CallConnected>(_onCallConnected);
    on<CallEnded>(_onCallEnded);
    on<CallFailed>(_onCallFailed);
    on<CallOnHold>(_onCallHold);
    on<CallResume>(_onCallResume);
    on<NetworkLost>(_onNetworkLost);
    on<NetworkRestored>(_onNetworkRestored);
    on<RetryCall>(_onRetryCall);
  }

  Future<void> _onStartCall(CallStarted event, Emitter<CallState> emit) async {
    if (state.status != CallStatus.idle) {
      return;
    }

    await _connect(emit);
  }

  void _onCallConnected(CallConnected event, Emitter<CallState> emit) {
    if (state.status != CallStatus.connecting &&
        state.status != CallStatus.reconnecting) {
      return;
    }

    emit(state.copyWith(status: CallStatus.connected, clearError: true));
  }

  void _onCallEnded(CallEnded event, Emitter<CallState> emit) {
    if (state.status != CallStatus.idle && state.status != CallStatus.ended) {
      return;
    }

    emit(state.copyWith(status: CallStatus.ended, clearError: true));
  }

  void _onCallFailed(CallFailed event, Emitter<CallState> emit) {
    emit(
      state.copyWith(status: CallStatus.failed, errorMessage: event.message),
    );
  }

  void _onCallHold(CallOnHold event, Emitter<CallState> emit) {
    if (state.status != CallStatus.connected) {
      return;
    }

    emit(state.copyWith(status: CallStatus.onHold, clearError: true));
  }

  void _onCallResume(CallResume event, Emitter<CallState> emit) {
    if (state.status != CallStatus.onHold) {
      return;
    }

    emit(state.copyWith(status: CallStatus.connected));
  }

  void _onNetworkLost(NetworkLost event, Emitter<CallState> emit) {
    if (state.status != CallStatus.connected &&
        state.status != CallStatus.onHold) {
      return;
    }

    emit(state.copyWith(status: CallStatus.reconnecting));
  }

  void _onNetworkRestored(NetworkRestored event, Emitter<CallState> emit) {
    if (state.status != CallStatus.reconnecting) {
      return;
    }

    emit(state.copyWith(status: CallStatus.connected));
  }

  //rety
  Future<void> _onRetryCall(RetryCall event, Emitter<CallState> emit) async {
    if (state.status != CallStatus.failed) {
      return;
    }

    await _connect(emit);
  }

  Future<void> _connect(Emitter<CallState> emit) async {
    emit(state.copyWith(status: CallStatus.connecting, clearError: true));

    try {
      await repository.startCall().timeout(const Duration(seconds: 10));

      if (emit.isDone) return;

      emit(state.copyWith(status: CallStatus.connected, clearError: true));
    } on TimeoutException {
      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CallStatus.failed,
          errorMessage: 'Connection timed out',
        ),
      );
    } catch (e) {
      if (emit.isDone) return;

      emit(
        state.copyWith(status: CallStatus.failed, errorMessage: e.toString()),
      );
    }
  }
}
