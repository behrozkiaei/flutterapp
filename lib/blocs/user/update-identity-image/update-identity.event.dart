// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class UpdateIdentityImageEvent extends Equatable {
  const UpdateIdentityImageEvent();

  @override
  List<Object> get props => [];
}

class UpdateIdentityImageButtonPressed extends UpdateIdentityImageEvent {
  final String shenasname;

  const UpdateIdentityImageButtonPressed({
    required this.shenasname,
  });

  @override
  List<Object> get props => [shenasname];

  @override
  String toString() =>
      'UpdateIdentityImageButtonPressed ';
}