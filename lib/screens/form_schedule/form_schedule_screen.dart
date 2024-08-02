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
import 'package:medicine_schedule/models/schedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScheduleScreen extends StatelessWidget {
  const FormScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormScheduleScreenContent();
  }
}

class FormScheduleScreenContent extends StatefulWidget {
  const FormScheduleScreenContent({super.key});

  @override
  State<FormScheduleScreenContent> createState() =>
      _FormScheduleScreenContentState();
}

class _FormScheduleScreenContentState extends State<FormScheduleScreenContent> {
  String? _selectedItem;
  TimeOfDay? _selectedTime;
  int m1 = 0;
  int m2 = 0;
  int m3 = 0;
  int m4 = 0;
  int m5 = 0;
  int m6 = 0;
  int m7 = 0;

  bool _medicine1 = false;
  bool _medicine2 = false;
  bool _medicine3 = false;
  bool _medicine4 = false;
  bool _medicine5 = false;
  bool _medicine6 = false;
  bool _medicine7 = false;

  final List<String> _dropdownItems = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    "Jum'at",
    'Sabtu',
    'Minggu',
  ];

  List<MedicineModel> _medicines = [];

  _saveSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scheduleList = prefs.getStringList('schedules') ?? [];

    ScheduleModel newSchedule = ScheduleModel(
      day: _selectedItem ?? '',
      time: _selectedTime.toString(),
      m1: m1.toString(),
      m2: m2.toString(),
      m3: m3.toString(),
      m4: m4.toString(),
      m5: m5.toString(),
      m6: m6.toString(),
      m7: m7.toString(),
    );

    scheduleList.add(json.encode(newSchedule.toJson()));
    await prefs.setStringList('schedules', scheduleList);
  }

  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> medicineList = prefs.getStringList('medicines') ?? [];
    setState(() {
      _medicines = medicineList
          .map((e) => MedicineModel.fromJson(json.decode(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Tambah Jadwal',
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
                      'Pilih Hari',
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Pilih hari'),
                          value: _selectedItem,
                          items: _dropdownItems.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    const Gap(8.0),
                    const Text(
                      'Pilih Jam',
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
                          controller: _timeController,
                          readOnly: true,
                          onTap: () => _selectTime(context),
                          decoration: const InputDecoration(
                            hintText: 'Pilih Jam',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8), // Adjust this value as needed
                          ),
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    const Text(
                      'Pilih Obat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m1 : 'Obat 1'),
                      value: _medicine1,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine1 = newValue ?? false;
                          if (!_medicine1) {
                            m1 = 0;
                          } else {
                            m1 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m2 : 'Obat 2'),
                      value: _medicine2,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine2 = newValue ?? false;
                          if (!_medicine2) {
                            m2 = 0;
                          } else {
                            m2 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m3 : 'Obat 3'),
                      value: _medicine3,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine3 = newValue ?? false;
                          if (!_medicine3) {
                            m3 = 0;
                          } else {
                            m3 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m4 : 'Obat 4'),
                      value: _medicine4,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine4 = newValue ?? false;
                          if (!_medicine4) {
                            m4 = 0;
                          } else {
                            m4 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m5 : 'Obat 5'),
                      value: _medicine5,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine5 = newValue ?? false;
                          if (!_medicine5) {
                            m5 = 0;
                          } else {
                            m5 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m6 : 'Obat 6'),
                      value: _medicine6,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine6 = newValue ?? false;
                          if (!_medicine6) {
                            m6 = 0;
                          } else {
                            m6 = 1;
                          }
                        });
                      },
                    ),
                    const Gap(4.0),
                    CheckboxListTile(
                      activeColor: Colors.lightBlue,
                      title: Text(
                          _medicines.isNotEmpty ? _medicines[0].m7 : 'Obat 7'),
                      value: _medicine7,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _medicine7 = newValue ?? false;
                          if (!_medicine7) {
                            m7 = 0;
                          } else {
                            m7 = 1;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70.0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: (_selectedItem != null && _selectedTime != null)
                    ? () {
                        _showAlertDialog(context);
                      }
                    : null,
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
          title: const Text('Simpan Jadwal'),
          content: const Text('Apakah anda yakin akan menyimpan jadwal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                _saveSchedule();
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
