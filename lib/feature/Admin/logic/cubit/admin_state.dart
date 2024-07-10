part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}
class AdminLoading extends AdminState {}

class AdminError extends AdminState {
  final String error;

  AdminError(this.error);
}
class AdminLoaded extends AdminState {}
