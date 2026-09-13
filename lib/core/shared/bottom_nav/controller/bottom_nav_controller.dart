import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarCubit extends Cubit<int> {
  BottomNavbarCubit() : super(0);

  void setIndex(int index) {
    emit(index);
  }
}
