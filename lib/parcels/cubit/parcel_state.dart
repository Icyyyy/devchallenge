part of 'parcel_cubit.dart';

@freezed
class ParcelState with _$ParcelState {
  const factory ParcelState({
    @Default([]) List<Parcel> parcels,
    Parcel? selectedParcel,
  }) = _Parcel;
}
