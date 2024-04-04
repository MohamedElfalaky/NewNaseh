import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/wallet_cubit/wallet_state.dart';
import 'package:nasooh/Data/repositories/wallet_repo/wallet_repo.dart';


class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  WalletRepo listRejectionRepo = WalletRepo();


  getDataWallet() async {
    try {
      emit(WalletLoading());
      final mList = await (listRejectionRepo.getData());
      emit(WalletLoaded(mList));
    } catch (e) {
      emit(WalletError());
    }
  }
}
