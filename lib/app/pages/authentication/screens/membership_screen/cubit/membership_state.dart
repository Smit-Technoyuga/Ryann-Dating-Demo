import 'package:equatable/equatable.dart';

class MembershipState extends Equatable {
  const MembershipState({this.isLoading = false, this.isSuccess = false});

  final bool isLoading;
  final bool isSuccess;

  MembershipState copyWith({bool? isLoading, bool? isSuccess}) {
    return MembershipState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
