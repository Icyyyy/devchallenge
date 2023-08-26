import 'package:devchallenge/parcels/cubit/parcel_cubit.dart';
import 'package:devchallenge/parcels/models/parcel.dart';
import 'package:devchallenge/parcels/widgets/parcel_card.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Paketklassen wählen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            BlocBuilder<ParcelCubit, ParcelState>(
              builder: (context, state) {
                var selectedPackage = context
                    .select((ParcelCubit cubit) => cubit.state)
                    .selectedParcel;
                List<Parcel> packages = state.parcels;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    Parcel package = packages[index];
                    return ParcelCard(
                      parcel: package,
                      isSelected: selectedPackage == package,
                      onTap: () =>
                          context.read<ParcelCubit>().selected(package),
                    );
                  },
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: context
                            .select((ParcelCubit cubit) => cubit.state)
                            .selectedParcel !=
                        null
                    ? () {}
                    : null,
                child: const Text('Weiter zum Kontaktformular'))
          ],
        ),
      ),
    );
  }
}
