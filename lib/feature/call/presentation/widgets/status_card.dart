// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:callapp/feature/call/presentation/bloc/call/call_state.dart';

class CallStatusCard extends StatelessWidget {
  final CallState state;
  const CallStatusCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(_icon, size: 90),
        const SizedBox(height: 20),
        Text(_statusText, style: Theme.of(context).textTheme.headlineSmall),
        if (state.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(state.errorMessage!, textAlign: TextAlign.center),
        ],
      ],
    );
  }

  IconData get _icon {
    switch (state.status) {
      case CallStatus.idle:
        return Icons.phone_disabled;

      case CallStatus.connecting:
        return Icons.phone_in_talk;

      case CallStatus.connected:
        return Icons.call;

      case CallStatus.onHold:
        return Icons.pause_circle;

      case CallStatus.reconnecting:
        return Icons.sync;

      case CallStatus.ended:
        return Icons.call_end;

      case CallStatus.failed:
        return Icons.error_outline;
    }
  }

  String get _statusText {
    switch (state.status) {
      case CallStatus.idle:
        return 'Ready to call';

      case CallStatus.connecting:
        return 'Connecting...';

      case CallStatus.connected:
        return 'Call connected';

      case CallStatus.onHold:
        return 'Call on hold';

      case CallStatus.reconnecting:
        return 'Reconnecting...';

      case CallStatus.ended:
        return 'Call ended';

      case CallStatus.failed:
        return 'Call failed';
    }
  }
}
