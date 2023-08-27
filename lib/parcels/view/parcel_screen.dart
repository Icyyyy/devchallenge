import 'package:devchallenge/parcels/cubit/parcel_cubit.dart';
import 'package:devchallenge/parcels/models/contact.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:devchallenge/parcels/widgets/contact_summary.dart';
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
                if (details.currentStep == 0) ...[
                  _buildNextButton(
                      isStepValid: parcelState.selectedParcel != null,
                      details: details),
                ] else if (details.currentStep == 1) ...[
                  _buildNextButton(
                      isStepValid: parcelState.isValidRecipient,
                      details: details),
                ] else if (details.currentStep == 2) ...[
                  _buildNextButton(
                      isStepValid: parcelState.isValidSender, details: details),
                ] else if (details.currentStep == 3) ...[
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () =>
                            context.read<ParcelCubit>().createParcelLabel(),
                        child: const Text('Paketschein erstellen'),
                      ))
                ]
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
                  onTap: () =>
                      context.read<ParcelCubit>().selectParcel(package),
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
    var state = context.watch<ParcelCubit>().state;
    Contact ctc =
        contact == ContactEnum.recipient ? state.recipient : state.sender;
    return Column(
      children: [
        const SizedBox(height: 16),
        FormTextField(
          onChanged: (value) => context
              .read<ParcelCubit>()
              .changeFirstname(value, contact: contact),
          labelText: 'Vorname (Optional)',
          errorText: ctc.firstname.displayError != null
              ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
              : null,
        ),
        const SizedBox(height: 8),
        FormTextField(
          onChanged: (value) => context
              .read<ParcelCubit>()
              .changeLastname(value, contact: contact),
          labelText: 'Nachname',
          errorText: ctc.lastname.displayError != null
              ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
              : null,
        ),
        const SizedBox(height: 8),
        FormTextField(
          onChanged: (value) =>
              context.read<ParcelCubit>().changeStreet(value, contact: contact),
          labelText: 'Straße',
          errorText: ctc.street.displayError != null
              ? 'Nur Zeichen von a-z und A-Z sind erlaubt'
              : null,
        ),
        const SizedBox(height: 8),
        FormTextField(
          onChanged: (value) => context
              .read<ParcelCubit>()
              .changehouseNumber(value, contact: contact),
          labelText: 'Hausnummer',
          errorText: ctc.houseNumber.displayError != null
              ? 'Nur Zeichen 0-9 und a-z sind erlaubt'
              : null,
        ),
        const SizedBox(height: 8),
        FormTextField(
            onChanged: (postCode) => context
                .read<ParcelCubit>()
                .changePostCode(postCode, contact: contact),
            labelText: 'PLZ',
            errorText: ctc.postCode.displayError != null
                ? 'Nur Zahlen und maximal 5 Zeichen sind erlaubt'
                : null,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(5),
            ]),
        const SizedBox(height: 8),
        FormTextField(
          onChanged: (value) => context
              .read<ParcelCubit>()
              .changeResidence(value, contact: contact),
          labelText: 'Wohnort',
          errorText: ctc.residence.displayError != null
              ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
              : null,
        ),
        const SizedBox(height: 8),
        FormTextField(
          onChanged: (value) =>
              context.read<ParcelCubit>().changeEmail(value, contact: contact),
          labelText: 'E-Mail (Optional)',
          errorText: ctc.email.displayError != null ? 'Ungültige E-Mail' : null,
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
        var recipient = state.recipient;
        var sender = state.sender;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (selectedParcel != null) ParcelCard(parcel: selectedParcel),
            ContactSummary(title: 'Empfänger', contact: recipient),
            ContactSummary(title: 'Absender', contact: sender)
          ],
        );
      },
    );
  }
}
