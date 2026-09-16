import 'package:bloc_test/bloc_test.dart';
import 'package:callapp/feature/call/data/datasource/call_service.dart';
import 'package:callapp/feature/call/data/repositories/call_repository_impl.dart';
import 'package:callapp/feature/call/presentation/bloc/call/call_bloc.dart';
import 'package:callapp/feature/call/presentation/bloc/call/call_event.dart';
import 'package:callapp/feature/call/presentation/bloc/call/call_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = CallRepositoryImpl(CallService());
  group('CallBloc', () {
    blocTest<CallBloc, CallState>(
      'starts in idle state',
      build: () => CallBloc(repository),
      verify: (bloc) {
        expect(bloc.state.status, CallStatus.idle);
      },
    );

    blocTest<CallBloc, CallState>(
      'moves from idle to connecting when call starts',
      build: () => CallBloc(repository),
      act: (bloc) => bloc.add(const CallStarted()),
      expect: () => [const CallState(status: CallStatus.connecting)],
    );

    blocTest<CallBloc, CallState>(
      'moves from connecting to connected',
      build: () => CallBloc(repository),
      act: (bloc) {
        bloc
          ..add(const CallStarted())
          ..add(const CallConnected());
      },
      expect: () => [
        const CallState(status: CallStatus.connecting),
        const CallState(status: CallStatus.connected),
      ],
    );

    blocTest<CallBloc, CallState>(
      'moves from connected to on hold',
      build: () => CallBloc(repository),
      seed: () => const CallState(status: CallStatus.connected),
      act: (bloc) => bloc.add(const CallOnHold()),
      expect: () => [const CallState(status: CallStatus.onHold)],
    );

    blocTest<CallBloc, CallState>(
      'ignores invalid transition from idle to on hold',
      build: () => CallBloc(repository),
      act: (bloc) => bloc.add(const CallOnHold()),
      expect: () => <CallState>[],
    );
  });
}
