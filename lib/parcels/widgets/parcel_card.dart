import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:flutter/material.dart';

class ParcelCard extends StatelessWidget {
  const ParcelCard(
      {super.key,
      required this.parcel,
      required this.onTap,
      this.isSelected = false,
      this.onTapInfoIcon});

  final Parcel parcel;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onTapInfoIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: onTap,
      child: Card(
        color: isSelected ? Theme.of(context).colorScheme.surfaceVariant : null,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(parcel.title), Text(parcel.price)],
                ),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  itemCount: parcel.bulletPoints.length,
                  itemBuilder: (context, index) {
                    return Text('\u2022 ${parcel.bulletPoints[index]}');
                  },
                ),
              ),
            ),
            if (onTapInfoIcon != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: InkWell(
                    onTap: onTapInfoIcon, child: const Icon(Icons.info)),
              ),
          ],
        ),
      ),
    );
  }
}
