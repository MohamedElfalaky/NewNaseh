import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/.dart';

part 'add_cirtificate_state.dart';

class AddCertificateCubit extends Cubit<AddCertificateState> {
  AddCertificateCubit() : super(AddCertificateInitial());

  void addCertificate() {
    emit(AddCertificateAdded());
  }
}
