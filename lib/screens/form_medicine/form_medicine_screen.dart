// Copyright 2024 ariefsetyonugroho
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicine_schedule/models/medicine_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormMedicineScreen extends StatelessWidget {
  final List<MedicineModel> medicineModel;

  const FormMedicineScreen({
    required this.medicineModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormMedicineScreenContent(
      medicineModel: medicineModel,
    );
  }
}

class FormMedicineScreenContent extends StatefulWidget {
  final List<MedicineModel> medicineModel;
  const FormMedicineScreenContent({
    required this.medicineModel,
    super.key,
  });

  @override
  State<FormMedicineScreenContent> createState() =>
      _FormMedicineScreenContentState();
}

class _FormMedicineScreenContentState extends State<FormMedicineScreenContent> {
  String m1 = 'Obat 1';
  String m2 = 'Obat 2';
  String m3 = 'Obat 3';
  String m4 = 'Obat 4';
  String m5 = 'Obat 5';
  String m6 = 'Obat 6';
  String m7 = 'Obat 7';
  List<MedicineModel> _medicines = [];

  _saveMedicine() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> medicineList = prefs.getStringList('medicines') ?? [];

    MedicineModel newMedicine = MedicineModel(
      m1: m1,
      m2: m2,
      m3: m3,
      m4: m4,
      m5: m5,
      m6: m6,
      m7: m7,
    );

    medicineList.add(json.encode(newMedicine.toJson()));
    await prefs.setStringList('medicines', medicineList);
  }

  _deleteAllMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('medicines');
  }

  @override
  void initState() {
    super.initState();
    _medicines = widget.medicineModel;
    if (_medicines.isNotEmpty) {
      m1 = _medicines[0].m1;
      m2 = _medicines[0].m2;
      m3 = _medicines[0].m3;
      m4 = _medicines[0].m4;
      m5 = _medicines[0].m5;
      m6 = _medicines[0].m6;
      m7 = _medicines[0].m7;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Edit Nama Obat',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukkan Nama Obat 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m1
                              : 'Obat 1',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m1 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 2',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m2
                              : 'Obat 2',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m2 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 3',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m3
                              : 'Obat 3',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m3 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 4',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m4
                              : 'Obat 4',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m4 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 5',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m5
                              : 'Obat 5',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m5 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 6',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m6
                              : 'Obat 6',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m6 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Masukkan Nama Obat 7',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: TextFormField(
                          initialValue: _medicines.isNotEmpty
                              ? _medicines[0].m7
                              : 'Obat 7',
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama obat',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            setState(() {
                              m7 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(16.0),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _showAlertDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Simpan Nama Obat'),
          content: const Text('Apakah anda yakin akan menyimpan nama obat?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllMedicines();
                _saveMedicine();
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
              child: const Text('Ya, Simpan'),
            ),
          ],
        );
      },
    );
  }
}
