import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

/// Entity placeholder
typedef UserOverviewStateEntity = List<UserModel>;

/// {@template user_overview_state}
/// UserOverviewState.
/// {@endtemplate}
sealed class UserOverviewState extends _$UserOverviewStateBase {
  /// {@macro user_overview_state}
  const UserOverviewState({
    required super.data,
    required super.message,
    super.error,
    super.stackTrace,
  });

  /// Idle
  /// {@macro user_overview_state}
  const factory UserOverviewState.idle({
    UserOverviewStateEntity? data,
    String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UserOverviewState$Idle;

  /// Processing
  /// {@macro user_overview_state}
  const factory UserOverviewState.processing({
    UserOverviewStateEntity? data,
    String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UserOverviewState$Processing;

  /// Failed
  /// {@macro user_overview_state}
  const factory UserOverviewState.failed({
    UserOverviewStateEntity? data,
    String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UserOverviewState$Failed;

  /// Initial
  /// {@macro user_overview_state}
  factory UserOverviewState.initial({
    UserOverviewStateEntity? data,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) => UserOverviewState$Idle(
    data: data,
    message: message ?? 'Initial',
    error: error,
    stackTrace: stackTrace,
  );
}

/// Idle
final class UserOverviewState$Idle extends UserOverviewState {
  const UserOverviewState$Idle({
    super.data,
    super.message = 'Idle',
    super.error,
    super.stackTrace,
  });

  @override
  String get type => 'idle';
}

/// Processing
final class UserOverviewState$Processing extends UserOverviewState {
  const UserOverviewState$Processing({
    super.data,
    super.message = 'Processing',
    super.error,
    super.stackTrace,
  });

  @override
  String get type => 'processing';
}

/// Failed
final class UserOverviewState$Failed extends UserOverviewState {
  const UserOverviewState$Failed({
    super.data,
    super.message = 'Failed',
    super.error,
    super.stackTrace,
  });

  @override
  String get type => 'failed';
}

/// Pattern matching for [UserOverviewState].
typedef UserOverviewStateMatch<R, S extends UserOverviewState> =
    R Function(S element);

@immutable
abstract base class _$UserOverviewStateBase {
  const _$UserOverviewStateBase({
    required this.data,
    required this.message,
    this.error,
    this.stackTrace,
  });

  /// Type alias for [UserOverviewState].
  abstract final String type;

  /// Data entity payload.
  @nonVirtual
  final UserOverviewStateEntity? data;

  /// Message or description.
  @nonVirtual
  final String message;

  /// Error object.
  @nonVirtual
  final Object? error;

  /// Stack trace object.
  @nonVirtual
  final StackTrace? stackTrace;

  /// Has data?
  bool get hasData => data != null;

  /// Check if is Idle.
  bool get isIdle => this is UserOverviewState$Idle;

  /// Check if is Processing.
  bool get isProcessing => this is UserOverviewState$Processing;

  /// Check if is Failed.
  bool get isFailed => this is UserOverviewState$Failed;

  /// Pattern matching for [UserOverviewState].
  R map<R>({
    required UserOverviewStateMatch<R, UserOverviewState$Idle> idle,
    required UserOverviewStateMatch<R, UserOverviewState$Processing> processing,
    required UserOverviewStateMatch<R, UserOverviewState$Failed> failed,
  }) => switch (this) {
    final UserOverviewState$Idle s => idle(s),
    final UserOverviewState$Processing s => processing(s),
    final UserOverviewState$Failed s => failed(s),
    _ => throw AssertionError(),
  };

  /// Pattern matching for [UserOverviewState].
  R maybeMap<R>({
    required R Function() orElse,
    UserOverviewStateMatch<R, UserOverviewState$Idle>? idle,
    UserOverviewStateMatch<R, UserOverviewState$Processing>? processing,
    UserOverviewStateMatch<R, UserOverviewState$Failed>? failed,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    failed: failed ?? (_) => orElse(),
  );

  /// Pattern matching for [UserOverviewState].
  R? mapOrNull<R>({
    UserOverviewStateMatch<R, UserOverviewState$Idle>? idle,
    UserOverviewStateMatch<R, UserOverviewState$Processing>? processing,
    UserOverviewStateMatch<R, UserOverviewState$Failed>? failed,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    failed: failed ?? (_) => null,
  );

  @override
  int get hashCode => Object.hash(type, data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _$UserOverviewStateBase &&
          type == other.type &&
          identical(data, other.data));

  @override
  String toString() => 'UserOverviewState.$type{message: $message}';
}

sealed class UserOverviewEvent {
  const UserOverviewEvent();

  const factory UserOverviewEvent.load() = UserOverviewLoad;
}

final class UserOverviewLoad extends UserOverviewEvent {
  const UserOverviewLoad();
}

class UserOverviewBloc extends Bloc<UserOverviewEvent, UserOverviewState> {
  UserOverviewBloc({required FetchUsersUseCase fetchAllUsersUseCase})
    : _fetchAllUsersUseCase = fetchAllUsersUseCase,
      super(UserOverviewState.initial()) {
    on<UserOverviewEvent>(
      (UserOverviewEvent event, Emitter<UserOverviewState> emit) async =>
          switch (event) {
            final UserOverviewLoad e => _onLoad(e, emit),
          },
    );
  }

  /// OK???
  final FetchUsersUseCase _fetchAllUsersUseCase;

  /// OR: final FutureUseCase<void, List<UserModel>> fetchAllUsersUseCase;

  Future<void> _onLoad(
    UserOverviewLoad event,
    Emitter<UserOverviewState> emit,
  ) async {
    emit(
      UserOverviewState.processing(
        data: state.data,
        message: 'Loading users...',
      ),
    );

    /// ??? error handling ??? error util ?
    try {
      final List<UserModel> result = await _fetchAllUsersUseCase.execute();
      emit(
        UserOverviewState.idle(
          data: result,
          message: 'Users loaded successfully',
        ),
      );
    } on AppException catch (e, s) {
      emit(
        UserOverviewState.failed(
          data: state.data,
          message: 'Failed to load users',
          error: e,
          stackTrace: s,
        ),
      );
    } catch (e, s) {
      emit(
        UserOverviewState.failed(
          data: state.data,
          message: 'Unexpected error',
          error: e,
          stackTrace: s,
        ),
      );
      // addError(e, s);
      // Or rethrow; ???
      rethrow;
    }
  }
}
