import 'package:devchallenge/parcels/forms/email.dart';
import 'package:devchallenge/parcels/forms/firstname.dart';
import 'package:devchallenge/parcels/forms/house_number.dart';
import 'package:devchallenge/parcels/forms/lastname.dart';
import 'package:devchallenge/parcels/forms/residence.dart';
import 'package:devchallenge/parcels/forms/street.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:devchallenge/parcels/models/recipient.dart';
import 'package:devchallenge/parcels/models/sender.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_cubit.freezed.dart';
part 'parcel_state.dart';

enum Contact {
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

  void incrementStepIndexOnTap(int index) {
    emit(state.copyWith(stepIndex: index));
  }

  void incrementStepIndex() {
    if (state.stepIndex < 2) {
      emit(state.copyWith(stepIndex: state.stepIndex + 1));
    }
  }

  void decrementStepIndex() {
    if (state.stepIndex > 0) {
      emit(state.copyWith(stepIndex: state.stepIndex - 1));
    }
  }

  void firstnameChanged(String value, {required Contact contact}) {
    final firstname = Firstname.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(firstname: firstname))
        : state.copyWith(sender: state.sender.copyWith(firstname: firstname)));
  }

  void lastnameChanged(String value, {required Contact contact}) {
    final lastname = Lastname.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(lastname: lastname))
        : state.copyWith(sender: state.sender.copyWith(lastname: lastname)));
  }

  void streetChanged(String value, {required Contact contact}) {
    final street = Street.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(recipient: state.recipient.copyWith(street: street))
        : state.copyWith(sender: state.sender.copyWith(street: street)));
  }

  void houseNumberChanged(String value, {required Contact contact}) {
    final houseNumber = HouseNumber.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(houseNumber: houseNumber))
        : state.copyWith(
            sender: state.sender.copyWith(houseNumber: houseNumber)));
  }

  void postCodeChanged(String value, {required Contact contact}) {
    int postCode = int.parse(value);
    emit(contact == Contact.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(postCode: postCode))
        : state.copyWith(sender: state.sender.copyWith(postCode: postCode)));
  }

  void residenceChanged(String value, {required Contact contact}) {
    final residence = Residence.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(
            recipient: state.recipient.copyWith(residence: residence))
        : state.copyWith(sender: state.sender.copyWith(residence: residence)));
  }

  void emailChanged(String value, {required Contact contact}) {
    final email = Email.dirty(value);
    emit(contact == Contact.recipient
        ? state.copyWith(recipient: state.recipient.copyWith(email: email))
        : state.copyWith(sender: state.sender.copyWith(email: email)));
  }
}
