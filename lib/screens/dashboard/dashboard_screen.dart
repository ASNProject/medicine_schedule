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
import 'package:go_router/go_router.dart';
import 'package:medicine_schedule/models/models.dart';
import 'package:medicine_schedule/routers/routes.dart';
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
  List<ScheduleModel> _schedules = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
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

  Future<void> _deleteSchedule(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scheduleList = prefs.getStringList('schedules') ?? [];
    if (scheduleList.isNotEmpty && index < scheduleList.length) {
      scheduleList.removeAt(index);
      await prefs.setStringList('schedules', scheduleList);
      _loadSchedules();
    }
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Jadwal Obat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.filter_list_rounded,
                          size: 20,
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
                              return ScheduleListItemCard(
                                schedule: schedule,
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
}
