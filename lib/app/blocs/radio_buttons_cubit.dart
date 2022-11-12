import 'package:flutter_bloc/flutter_bloc.dart';

mixin SelectedAddressTypeCubit on Cubit<double> {}
mixin SelectedReviewStarsCubit on Cubit<double> {}

class RadioButtonCubit extends Cubit<double>
    with SelectedReviewStarsCubit, SelectedAddressTypeCubit {
  RadioButtonCubit() : super(0);

  void changeSelected(double selected) => emit(selected);

  void reset() => emit(0);
}
