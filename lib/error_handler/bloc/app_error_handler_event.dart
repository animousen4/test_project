part of 'app_error_handler_bloc.dart';

sealed class AppErrorHandlerEvent {
  const AppErrorHandlerEvent();
}

class CoreEventReceived extends AppErrorHandlerEvent {

  const CoreEventReceived(this.data);
  final CoreEvent data;
}

class DomainEventReceived extends AppErrorHandlerEvent {

  const DomainEventReceived(this.data);
  final DomainEvent data;
}
