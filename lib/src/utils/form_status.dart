import 'package:equatable/equatable.dart';

abstract class FormStatus extends Equatable {
  const FormStatus();

  @override
  List<Object?> get props => [];
}

class InitFormStatus extends FormStatus {
  const InitFormStatus();
}

class LoadingFormStatus extends FormStatus {
  const LoadingFormStatus();
}

class SuccessFormStatus extends FormStatus {
  const SuccessFormStatus();
}

class ErrorFormStatus extends FormStatus {
  const ErrorFormStatus();
}
