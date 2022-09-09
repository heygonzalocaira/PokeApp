part of 'internet_connection_cubit.dart';

enum InternetStatus { haveInternet, noInternet }

class InternetConnectionState extends Equatable {
  final InternetStatus status;

  const InternetConnectionState({this.status = InternetStatus.haveInternet});

  InternetConnectionState copyWith({InternetStatus? status}) {
    return InternetConnectionState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
