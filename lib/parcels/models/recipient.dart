import 'package:devchallenge/parcels/forms/email.dart';
import 'package:devchallenge/parcels/forms/firstname.dart';
import 'package:devchallenge/parcels/forms/house_number.dart';
import 'package:devchallenge/parcels/forms/lastname.dart';
import 'package:devchallenge/parcels/forms/residence.dart';
import 'package:devchallenge/parcels/forms/street.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipient.freezed.dart';

@freezed
class Recipient with _$Recipient {
  const factory Recipient(
      {Firstname? firstname,
      Lastname? lastname,
      Street? street,
      HouseNumber? houseNumber,
      int? postCode,
      Email? email,
      Residence? residence}) = _Recipient;
}
