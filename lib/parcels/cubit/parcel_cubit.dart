import 'package:devchallenge/parcels/forms/email.dart';
import 'package:devchallenge/parcels/forms/firstname.dart';
import 'package:devchallenge/parcels/forms/house_number.dart';
import 'package:devchallenge/parcels/forms/lastname.dart';
import 'package:devchallenge/parcels/forms/post_code.dart';
import 'package:devchallenge/parcels/forms/residence.dart';
import 'package:devchallenge/parcels/forms/street.dart';
import 'package:devchallenge/parcels/models/contact.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_cubit.freezed.dart';
part 'parcel_state.dart';

enum ContactEnum {
  sender,
  recipient,
}

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
            bulletPoints: const [
              'längste und kürzeste Seite zusammen max. 50 cm',
              'maximal 25 kg'
            ],
          ),
          Parcel(
            title: 'M-Paket',
            price: '6,75€',
            bulletPoints: const [
              'längste und kürzeste Seite zusammen max. 80 cm',
              'maximal 25 kg'
            ],
          ),
          Parcel(
            title: 'L-Paket',
            price: '10,95€',
            bulletPoints: const [
              'längste und kürzeste Seite zusammen max. 120 cm',
              'maximal 25 kg'
            ],
          )
        ]));

  void selectParcel(Parcel parcel) {
    emit(state.copyWith(
        selectedParcel: state.selectedParcel == parcel ? null : parcel));
  }

  void incrementStepIndexOnTap(int index) {
    emit(state.copyWith(stepIndex: index));
  }

  void incrementStepIndex() {
    if (state.stepIndex < 3) {
      emit(state.copyWith(stepIndex: state.stepIndex + 1));
    }
  }

  void decrementStepIndex() {
    if (state.stepIndex > 0) {
      emit(state.copyWith(stepIndex: state.stepIndex - 1));
    }
  }

  void createParcelLabel() {
    // TODO send data to backend
  }

  void changeFirstname(String value, {required ContactEnum contact}) {
    final firstname = Firstname.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(firstname: firstname),
            isValidRecipient: Formz.validate([
              //    firstname,
              state.recipient.lastname,
              state.recipient.street,
              state.recipient.houseNumber,
              state.recipient.postCode,
              //state.recipient.email,
              state.recipient.residence,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(firstname: firstname),
            isValidSender: Formz.validate([
              //  firstname,
              state.sender.lastname,
              state.sender.street,
              state.sender.houseNumber,
              state.sender.postCode,
              // state.sender.email,
              state.sender.residence,
            ]),
          ));
  }

  void changeLastname(String value, {required ContactEnum contact}) {
    final lastname = Lastname.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(lastname: lastname),
            isValidRecipient: Formz.validate([
              //   state.recipient.firstname,
              lastname,
              state.recipient.street,
              state.recipient.houseNumber,
              state.recipient.postCode,
              //  state.recipient.email,
              state.recipient.residence,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(lastname: lastname),
            isValidSender: Formz.validate([
              //  state.sender.firstname,
              lastname,
              state.sender.street,
              state.sender.houseNumber,
              state.sender.postCode,
              //  state.sender.email,
              state.sender.residence,
            ]),
          ));
  }

  void changeStreet(String value, {required ContactEnum contact}) {
    final street = Street.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(street: street),
            isValidRecipient: Formz.validate([
              //   state.recipient.firstname,
              state.recipient.lastname,
              street,
              state.recipient.houseNumber,
              state.recipient.postCode,
              // state.recipient.email,
              state.recipient.residence,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(street: street),
            isValidSender: Formz.validate([
              //  state.sender.firstname,
              state.sender.lastname,
              street,
              state.sender.houseNumber,
              state.sender.postCode,
              // state.sender.email,
              state.sender.residence,
            ]),
          ));
  }

  void changehouseNumber(String value, {required ContactEnum contact}) {
    final houseNumber = HouseNumber.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(houseNumber: houseNumber),
            isValidRecipient: Formz.validate([
              // state.recipient.firstname,
              state.recipient.lastname,
              state.recipient.street,
              houseNumber,
              state.recipient.postCode,
              //   state.recipient.email,
              state.recipient.residence,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(houseNumber: houseNumber),
            isValidSender: Formz.validate([
              // state.sender.firstname,
              state.sender.lastname,
              state.sender.street,
              houseNumber,
              state.sender.postCode,
              // state.sender.email,
              state.sender.residence,
            ]),
          ));
  }

  void changePostCode(String value, {required ContactEnum contact}) {
    final postCode = PostCode.dirty(value);

    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(postCode: postCode),
            isValidRecipient: Formz.validate([
              //  state.recipient.firstname,
              state.recipient.lastname,
              state.recipient.street,
              state.recipient.houseNumber,
              postCode,
              //  state.recipient.email,
              state.recipient.residence,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(postCode: postCode),
            isValidSender: Formz.validate([
              //  state.sender.firstname,
              state.sender.lastname,
              state.sender.street,
              state.sender.houseNumber,
              postCode,
              //  state.sender.email,
              state.sender.residence,
            ]),
          ));
  }

  void changeResidence(String value, {required ContactEnum contact}) {
    final residence = Residence.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(residence: residence),
            isValidRecipient: Formz.validate([
              // state.recipient.firstname,
              state.recipient.lastname,
              state.recipient.street,
              state.recipient.houseNumber,
              state.recipient.postCode,
              residence,
              //  state.recipient.email,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(residence: residence),
            isValidSender: Formz.validate([
              //  state.sender.firstname,
              state.sender.lastname,
              state.sender.street,
              state.sender.houseNumber,
              state.sender.postCode,
              residence,
              //  state.sender.email,
            ]),
          ));
  }

  void changeEmail(String value, {required ContactEnum contact}) {
    final email = Email.dirty(value);
    emit(contact == ContactEnum.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(email: email),
            isValidRecipient: Formz.validate([
              // state.recipient.firstname,
              state.recipient.lastname,
              state.recipient.street,
              state.recipient.houseNumber,
              state.recipient.postCode,
              state.recipient.residence,
              //   email,
            ]),
          )
        : state.copyWith(
            sender: state.sender.copyWith(email: email),
            isValidSender: Formz.validate([
              //  state.sender.firstname,
              state.sender.lastname,
              state.sender.street,
              state.sender.houseNumber,
              state.sender.postCode,
              state.sender.residence,
              //     email,
            ]),
          ));
  }

  @override
  void onChange(Change<ParcelState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('$error, $stackTrace');
    }
    super.onError(error, stackTrace);
  }
}
