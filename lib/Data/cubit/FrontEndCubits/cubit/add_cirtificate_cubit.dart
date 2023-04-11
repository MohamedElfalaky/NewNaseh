import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_cirtificate_state.dart';

class AddCirtificateCubit extends Cubit<AddCirtificateState> {
  AddCirtificateCubit() : super(AddCirtificateInitial());

  void addCirtificate() {
    emit(AddCirtificateAdded());
  }
}
