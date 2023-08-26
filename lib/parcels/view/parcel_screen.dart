import 'package:devchallenge/parcels/cubit/parcel_cubit.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
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
    var selectedParcel =
        context.select((ParcelCubit cubit) => cubit.state).selectedParcel;
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
            context.read<ParcelCubit>().incrementStepIndexOnTap(index);
          },
          controlsBuilder: (context, details) {
            return Align(
              alignment: Alignment.bottomRight,
              child: Row(children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed:
                        selectedParcel != null ? details.onStepContinue : null,
                    child: const Text('Weiter'),
                  ),
                ),
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
              content: ContactForm(contact: Contact.recipient),
            ),
            Step(
              title: Text('Absender'),
              content: ContactForm(contact: Contact.sender),
            ),
            Step(
              title: Text('Übersicht'),
              content: Text('hi'),
            )
          ],
        ),
      ),
    );
  }
}

class ParcelSelection extends StatelessWidget {
  const ParcelSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var selectedPackage = context
                .select((ParcelCubit cubit) => cubit.state)
                .selectedParcel;
            List<Parcel> packages = state.parcels;
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                Parcel package = packages[index];
                return ParcelCard(
                  parcel: package,
                  isSelected: selectedPackage == package,
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

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var firstname = contact == Contact.recipient
                ? state.recipient.firstname
                : state.sender.firstname;
            return TextField(
              onChanged: (firstname) => context
                  .read<ParcelCubit>()
                  .firstnameChanged(firstname, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Vorname',
                errorText: firstname?.displayError != null
                    ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
                    : null,
              ),
            );
          },
        ),
        //  _EmailInput(),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var lastname = contact == Contact.recipient
                ? state.recipient.lastname
                : state.sender.lastname;
            return TextField(
              onChanged: (lastname) => context
                  .read<ParcelCubit>()
                  .lastnameChanged(lastname, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nachname',
                errorText: lastname?.displayError != null
                    ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var street = contact == Contact.recipient
                ? state.recipient.street
                : state.sender.street;
            return TextField(
              onChanged: (street) => context
                  .read<ParcelCubit>()
                  .streetChanged(street, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Straße',
                errorText: street?.displayError != null
                    ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var houseNumber = contact == Contact.recipient
                ? state.recipient.houseNumber
                : state.sender.houseNumber;
            return TextField(
              onChanged: (houseNumber) => context
                  .read<ParcelCubit>()
                  .houseNumberChanged(houseNumber, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Hausnummer',
                errorText: houseNumber?.displayError != null
                    ? 'Nur Zeichen 0-9 und a-z sind erlaubt'
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            return TextField(
              onChanged: (postCode) => context
                  .read<ParcelCubit>()
                  .postCodeChanged(postCode, contact: contact),
              maxLength: 5,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PLZ',
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var residence = contact == Contact.recipient
                ? state.recipient.residence
                : state.sender.residence;
            return TextField(
              onChanged: (residence) => context
                  .read<ParcelCubit>()
                  .residenceChanged(residence, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Wohnort',
                errorText: residence?.displayError != null
                    ? 'Nur Zeichen von a-z oder A-Z sind erlaubt'
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<ParcelCubit, ParcelState>(
          builder: (context, state) {
            var email = contact == Contact.recipient
                ? state.recipient.email
                : state.sender.email;
            return TextField(
              onChanged: (email) => context
                  .read<ParcelCubit>()
                  .emailChanged(email, contact: contact),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'E-Mail',
                errorText:
                    email?.displayError != null ? 'Ungültige E-Mail' : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
