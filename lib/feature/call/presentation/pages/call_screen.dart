import 'package:callapp/feature/call/presentation/bloc/call/call_bloc.dart';
import 'package:callapp/feature/call/presentation/bloc/call/call_state.dart';
import 'package:callapp/feature/call/presentation/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call App')),
      body: BlocConsumer<CallBloc, CallState>(
        listener: (context, state) {
          if (state.status == CallStatus.failed && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CallStatusCard(state: state),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
