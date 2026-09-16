# callapp

A Flutter application that demonstrates a reliable and predictable call lifecycle using BLoC state management, repository abstraction, network monitoring, timeout handling, retry mechanisms, and guarded state transitions.

Call Lifecycle

The application manages the following states:

IDLE
 │
 │ Start Call
 ▼
CONNECTING
 │
 ├── Connection Success ─────────► CONNECTED
 │
 ├── Timeout ────────────────────► FAILED
 │
 └── Error ──────────────────────► FAILED
                                      │
                                      │ Retry
                                      ▼
                                  CONNECTING


CONNECTED
 │
 ├── Hold ───────────────────────► ON HOLD
 │                                    │
 │                                    │ Resume
 │                                    ▼
 │                                CONNECTED
 │
 ├── Network Lost ───────────────► RECONNECTING
 │                                    │
 │                    ┌───────────────┴───────────────┐
 │                    │                               │
 │                    ▼                               ▼
 │                Connected                     Retry Failed
 │                    │                               │
 │                    ▼                               ▼
 │                CONNECTED                        FAILED
 │
 └── End Call ───────────────────► ENDED


Project Structure
lib/
│
├── feature/
│   └── call/
│       │
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── call_service.dart
│       │   │   
│       │   │
│       │   └── repositories/
│       │       └── call_repository_impl.dart
│       │
│       ├── domain/
│       │   └── repositories/
│       │       └── call_repository.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   └── call/
│           │       ├── call_bloc.dart
│           │       ├── call_event.dart
│           │       └── call_state.dart
│           │
│           ├
│           │   
│           │
│           └── pages/
│               └── call_screen.dart
│
└── main.dart