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

import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_schedule/models/models.dart';
import 'package:medicine_schedule/routers/routes.dart';
import 'package:medicine_schedule/utils/utils.dart';
import 'package:medicine_schedule/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DashboardScreenContent();
  }
}

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({
    super.key,
  });

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<ScheduleModel> _schedules = [];
  List<MedicineModel> _medicines = [];
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSchedules();
    _loadMedicines();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
      _scheduleAlarm();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scheduleList = prefs.getStringList('schedules') ?? [];
    setState(() {
      _schedules = scheduleList
          .map((e) => ScheduleModel.fromJson(json.decode(e)))
          .toList();
    });
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

  Future<void> _deleteSchedule(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scheduleList = prefs.getStringList('schedules') ?? [];
    if (scheduleList.isNotEmpty && index < scheduleList.length) {
      scheduleList.removeAt(index);
      await prefs.setStringList('schedules', scheduleList);
      _loadSchedules();
    }
  }

  Future<void> _scheduleAlarm() async {
    for (var schedule in _schedules) {
      final dayIndex = _dayToIndex(schedule.day);
      final scheduleTime = parseAndFormatTimeOfDayString(schedule.time);
      final scheduleHour = int.parse(scheduleTime.split(':')[0]);
      final scheduleMinute = int.parse(scheduleTime.split(':')[1]);

      if (dayIndex == DateTime.now().weekday) {
        if (scheduleHour == DateTime.now().hour &&
            scheduleMinute == DateTime.now().minute) {
          NotificationHelper.scheduledNotification(
              'Jadwal Minum Obat', 'Waktunya minum obat');
          _sendData(
            dayIndex.toString(),
            scheduleTime,
            schedule.m1,
            schedule.m2,
            schedule.m3,
            schedule.m4,
            schedule.m5,
            schedule.m6,
            schedule.m7,
          );
        }
      }
    }
  }

  int _dayToIndex(String day) {
    switch (day) {
      case 'Senin':
        return 1;
      case 'Selasa':
        return 2;
      case 'Rabu':
        return 3;
      case 'Kamis':
        return 4;
      case "Jum'at":
        return 5;
      case 'Sabtu':
        return 6;
      case 'Minggu':
        return 7;
      default:
        return 1;
    }
  }

  void _sendData(
    String day,
    String time,
    String m1,
    String m2,
    String m3,
    String m4,
    String m5,
    String m6,
    String m7,
  ) {
    _databaseReference.child('data').set({
      'day': day,
      'time': time,
      'a': m1,
      'b': m2,
      'c': m3,
      'd': m4,
      'e': m5,
      'f': m6,
      'g': m7,
      'notif': '1',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Medicine Schedule App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  bool? data = await GoRouter.of(context).pushNamed(
                    AppConstanst.formMedicineScreen,
                    extra: _medicines,
                  );

                  if (data == true) {
                    _loadMedicines();
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.edit),
                    Gap(4.0),
                    Text(
                      'Edit Obat',
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: ()  {
                  _showAlertDialog(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout),
                    Gap(4.0),
                    Text(
                      'Keluar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar Jadwal Obat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20.0),
                  _schedules.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Gap(8.0),
                            itemCount: _schedules.length,
                            itemBuilder: (context, index) {
                              final schedule = _schedules[index];
                              final medicine = _medicines.length > index
                                  ? _medicines[index]
                                  : null;
                              return ScheduleListItemCard(
                                schedule: schedule,
                                medicine: medicine,
                                onDelete: () => _deleteSchedule(index),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('Tidak ada jadwal'),
                        )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70.0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: () async {
                  bool? data = await GoRouter.of(context).pushNamed(
                    AppConstanst.formScheduleScreen,
                  );
                  if (data == true) {
                    _loadSchedules();
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  'Tambah Jadwal',
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

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    if (context.mounted) {
      GoRouter.of(context).pushReplacement('/');
    }
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah anda yakin akan keluar dari aplikasi?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _logout(context);
              },
              child: const Text('Ya, Keluar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }
}
