import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:pet_medical/models/pets.dart';
import 'package:pet_medical/models/adi_pupils.dart';
import 'package:pet_medical/pupil_card.dart';
//import 'package:pet_medical/repository/data_repository.dart';
import 'package:pet_medical/repository/adi_repository.dart';

import 'add_pet_dialog.dart';

class AdiList extends StatefulWidget {
  const AdiList({Key? key}) : super(key: key);
  @override
  _AdiListState createState() => _AdiListState();
}

class _AdiListState extends State<AdiList> {
  // TODO Add Data Repository
  //final DataRepository repository = DataRepository();
  final AdiRepository repository = AdiRepository();

  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pupils'), //Pets
      ),
      // TODO Add StreamBuilder
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPet();
        },
        tooltip: 'Add Pupil',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addPet() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddPetDialog();
      },
    );
  }

  // TODO Add _buildList
  // 1
  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      // 2
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

// 3
  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final pupil = Pupils.fromSnapshot(snapshot);

    return PupilCard(pupil: pupil, boldStyle: boldStyle);
  }
}
