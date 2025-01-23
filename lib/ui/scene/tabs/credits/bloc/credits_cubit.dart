import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/tabs/credits/bloc/credits_state.dart';

class CreditsCubit extends Cubit<CreditState> {
  CreditsCubit() : super(CreditInitial());
}
