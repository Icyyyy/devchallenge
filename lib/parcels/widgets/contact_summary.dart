import 'package:devchallenge/parcels/models/contact.dart';
import 'package:flutter/material.dart';

class ContactSummary extends StatelessWidget {
  const ContactSummary({
    super.key,
    required this.title,
    required this.contact,
  });

  final String title;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${contact.firstname.value} ${contact.lastname.value}"),
                Text("${contact.postCode.value} ${contact.residence.value}"),
                Text("${contact.street.value} ${contact.houseNumber.value}"),
                Text(contact.email.value),
              ],
            )),
      ]),
    );
  }
}
