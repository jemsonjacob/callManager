import 'package:callapp/feature/call/data/datasource/call_service.dart';

import 'package:callapp/feature/call/data/repositories/call_repository_impl.dart';
import 'package:callapp/feature/call/presentation/bloc/call/call_bloc.dart';
import 'package:callapp/feature/call/presentation/pages/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Data layer dependencies
    final callService = CallService();
    // final networkMonitor = NetworkMonitor();

    // Repository
    final repository = CallRepositoryImpl(callService);

    return MaterialApp(
      title: 'Call Lifecycle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<CallBloc>(
        create: (context) => CallBloc(repository),
        child: const CallScreen(),
      ),
    );
  }
}
