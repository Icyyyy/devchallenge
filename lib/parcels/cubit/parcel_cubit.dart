import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_cubit.freezed.dart';
part 'parcel_state.dart';

class ParcelCubit extends Cubit<ParcelState> {
  ParcelCubit()
      : super(ParcelState(parcels: [
          Parcel(
            title: 'XS-Paket',
            price: '4,5€',
            bulletPoints: const [
              'längste und kürzeste Seite zusammen max. 37 cm',
              'maximal 25 kg'
            ],
          ),
          Parcel(
            title: 'S-Paket',
            price: '4,95€',
            bulletPoints: [
              'längste und kürzeste Seite zusammen max. 50 cm',
              'maximal 25 kg'
            ],
          ),
          Parcel(
            title: 'L-Paket',
            price: '6,75€',
            bulletPoints: [
              'längste und kürzeste Seite zusammen max. 80 cm',
              'maximal 25 kg'
            ],
          ),
          Parcel(
            title: 'M-Paket',
            price: '10,95€',
            bulletPoints: [
              'längste und kürzeste Seite zusammen max. 120 cm',
              'maximal 25 kg'
            ],
          )
        ]));

  void selected(Parcel parcel) {
    emit(state.copyWith(
        selectedParcel: state.selectedParcel == parcel ? null : parcel));
  }
}
