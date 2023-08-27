part of 'parcel_cubit.dart';

@freezed
class ParcelState with _$ParcelState {
  const factory ParcelState({
    @Default([]) List<Parcel> parcels,
    Parcel? selectedParcel,
    @Default(0) int stepIndex,
    FormzSubmissionStatus? recipientStatus,
    @Default(Contact()) Contact recipient,
    @Default(false) bool isValidRecipient,
    @Default(Contact()) Contact sender,
    @Default(false) bool isValidSender,
  }) = _Parcel;
}
