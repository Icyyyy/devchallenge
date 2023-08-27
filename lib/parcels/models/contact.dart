import 'package:devchallenge/parcels/forms/email.dart';
import 'package:devchallenge/parcels/forms/firstname.dart';
import 'package:devchallenge/parcels/forms/house_number.dart';
import 'package:devchallenge/parcels/forms/lastname.dart';
import 'package:devchallenge/parcels/forms/post_code.dart';
import 'package:devchallenge/parcels/forms/residence.dart';
import 'package:devchallenge/parcels/forms/street.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    @Default(Firstname.pure()) Firstname firstname,
    @Default(Lastname.pure()) Lastname lastname,
    @Default(Street.pure()) Street street,
    @Default(HouseNumber.pure()) HouseNumber houseNumber,
    @Default(PostCode.pure()) PostCode postCode,
    @Default(Residence.pure()) Residence residence,
    @Default(Email.pure()) Email email,
  }) = _Contact;
}
