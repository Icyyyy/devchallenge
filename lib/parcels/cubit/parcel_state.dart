part of 'parcel_cubit.dart';

@freezed
class ParcelState with _$ParcelState {
  const factory ParcelState({
    @Default([]) List<Parcel> parcels,
    Parcel? selectedParcel,
    @Default(0) int stepIndex,
    FormzSubmissionStatus? recipientStatus,
    @Default(Recipient()) Recipient recipient,
    @Default(Sender()) Sender sender,
  }) = _Parcel;
}
