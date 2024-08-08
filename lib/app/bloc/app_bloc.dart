import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';
class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription _userSubscription;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) { // Initial state set to unauthenticated
    // Load the initial state asynchronously
    _loadInitialState();

    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        add(_AppUserChanged(user));
      },
    );
  }

  Future<void> _loadInitialState() async {
    final currentUser = await _authenticationRepository.currentUser;

    if (currentUser.isNotEmpty) {
      emit(AppState.authenticated(currentUser));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
    _authenticationRepository.logOut();
  }

  //get the current user from the repository
  Future<UserModel?> get currentUser => _authenticationRepository.currentUser;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
