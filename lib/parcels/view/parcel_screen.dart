import 'package:devchallenge/parcels/cubit/parcel_cubit.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:devchallenge/parcels/widgets/form_text_field.dart';
import 'package:devchallenge/parcels/widgets/parcel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParcelScreen extends StatelessWidget {
  const ParcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ParcelCubit(), child: const ParcelView());
  }
}

class ParcelView extends StatelessWidget {
  const ParcelView({super.key});

  @override
  Widget build(BuildContext context) {
    var parcelState = context.watch<ParcelCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Paketschein erstellen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stepper(
          currentStep:
              context.select((ParcelCubit cubit) => cubit.state).stepIndex,
          onStepContinue: () {
            context.read<ParcelCubit>().incrementStepIndex();
          },
          onStepTapped: (int index) {
            if (index < parcelState.stepIndex) {
              context.read<ParcelCubit>().incrementStepIndexOnTap(index);
            }
          },
          controlsBuilder: (context, details) {
            return Align(
              alignment: Alignment.bottomRight,
              child: Row(children: <Widget>[
                if (details.currentStep == 0)
                  _buildNextButton(
                      isStepValid: parcelState.selectedParcel != null,
                      details: details),
                if (details.currentStep == 1)
                  _buildNextButton(
                      isStepValid: parcelState.isValidRecipient,
                      details: details),
                if (details.currentStep == 2)
                  _buildNextButton(
                      isStepValid: parcelState.isValidSender, details: details),
              ]),
            );
          },
          steps: const [
            Step(
              title: Text('Paketklasse'),
              content: ParcelSelection(),
            ),
            Step(
              title: Text('Empfänger'),
              content: ContactForm(contact: ContactEnum.recipient),
            ),
            Step(
              title: Text('Absender'),
              content: ContactForm(contact: ContactEnum.sender),
            ),
            Step(title: Text('Übersicht'), content: Summary()),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(
      {required bool isStepValid, required ControlsDetails details}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: isStepValid ? details.onStepContinue : null,
        child: const Text('Weiter'),
      ),
    );
  }
}

class ParcelSelection extends StatelessWidget {
  const ParcelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.selectedParcel != current.selectedParcel,
          builder: (context, state) {
            List<Parcel> packages = state.parcels;
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                Parcel package = packages[index];
                return ParcelCard(
                  parcel: package,
                  isSelected: state.selectedParcel == package,
                  onTap: () => context.read<ParcelCubit>().selected(package),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({super.key, required this.contact});

  final ContactEnum contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.firstname != current.recipient.firstname ||
              previous.sender.firstname != current.sender.firstname,
          builder: (context, state) {
            var firstname = contact == ContactEnum.recipient
                ? state.recipient.firstname
                : state.sender.firstname;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .firstnameChanged(value, contact: contact),
              labelText: 'Vorname',
              errorText: firstname.displayError != null
                  ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
                  : null,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.lastname != current.recipient.lastname ||
              previous.sender.lastname != current.sender.lastname,
          builder: (context, state) {
            var lastname = contact == ContactEnum.recipient
                ? state.recipient.lastname
                : state.sender.lastname;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .lastnameChanged(value, contact: contact),
              labelText: 'Nachname',
              errorText: lastname.displayError != null
                  ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
                  : null,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.street != current.recipient.street ||
              previous.sender.street != current.sender.street,
          builder: (context, state) {
            var street = contact == ContactEnum.recipient
                ? state.recipient.street
                : state.sender.street;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .streetChanged(value, contact: contact),
              labelText: 'Straße',
              errorText: street.displayError != null
                  ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
                  : null,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.houseNumber != current.recipient.houseNumber ||
              previous.sender.houseNumber != current.sender.houseNumber,
          builder: (context, state) {
            var houseNumber = contact == ContactEnum.recipient
                ? state.recipient.houseNumber
                : state.sender.houseNumber;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .houseNumberChanged(value, contact: contact),
              labelText: 'Hausnummer',
              errorText: houseNumber.displayError != null
                  ? 'Nur Zeichen 0-9 und a-z sind erlaubt'
                  : null,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.postCode != current.recipient.postCode ||
              previous.sender.postCode != current.sender.postCode,
          builder: (context, state) {
            var postCode = contact == ContactEnum.recipient
                ? state.recipient.postCode
                : state.sender.postCode;
            return FormTextField(
                onChanged: (postCode) => context
                    .read<ParcelCubit>()
                    .postCodeChanged(postCode, contact: contact),
                labelText: 'PLZ',
                errorText: postCode.displayError != null
                    ? 'Nur Zahlen und maximal 5 Zeichen sind erlaubt'
                    : null,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ]);
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.residence != current.recipient.residence ||
              previous.sender.residence != current.sender.residence,
          builder: (context, state) {
            var residence = contact == ContactEnum.recipient
                ? state.recipient.residence
                : state.sender.residence;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .residenceChanged(value, contact: contact),
              labelText: 'Wohnort',
              errorText: residence.displayError != null
                  ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
                  : null,
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          buildWhen: (previous, current) =>
              previous.recipient.email != current.recipient.email ||
              previous.sender.email != current.sender.email,
          builder: (context, state) {
            var email = contact == ContactEnum.recipient
                ? state.recipient.email
                : state.sender.email;
            return FormTextField(
              onChanged: (value) => context
                  .read<ParcelCubit>()
                  .emailChanged(value, contact: contact),
              labelText: 'E-Mail',
              errorText: email.displayError != null ? 'Ungültige E-Mail' : null,
            );
          },
        ),
      ],
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelCubit, ParcelState>(
      builder: (context, state) {
        var selectedParcel = state.selectedParcel;
        return Column(
          children: [
            if (selectedParcel != null) ParcelCard(parcel: selectedParcel),
          ],
        );
      },
    );
  }
}
