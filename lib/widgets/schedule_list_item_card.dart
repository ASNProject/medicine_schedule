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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicine_schedule/models/models.dart';
import 'package:medicine_schedule/utils/utils.dart';

class ScheduleListItemCard extends StatelessWidget {
  final ScheduleModel schedule;
  final VoidCallback onDelete;
  const ScheduleListItemCard({
    required this.schedule,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 20,
                        ),
                        const Gap(8.0),
                        Text(
                          schedule.day,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Gap(4.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_clock,
                          size: 20,
                        ),
                        const Gap(8.0),
                        Text(
                          parseAndFormatTimeOfDayString(schedule.time),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'Daftar Obat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(8.0),
                    Wrap(
                      children: [
                        _buildMedicineList(context, schedule.m1, 'Obat 1'),
                        _buildMedicineList(context, schedule.m2, 'Obat 2'),
                        _buildMedicineList(context, schedule.m3, 'Obat 3'),
                        _buildMedicineList(context, schedule.m4, 'Obat 4'),
                        _buildMedicineList(context, schedule.m5, 'Obat 5'),
                        _buildMedicineList(context, schedule.m6, 'Obat 6'),
                        _buildMedicineList(context, schedule.m7, 'Obat 7'),
                      ],
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Jadwal'),
          content: const Text('Apakah anda yakin akan menghapus jadwal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              child: const Text('Ya, Hapus'),
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

  _buildMedicineList(
    BuildContext context,
    String status,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: status == '1' ? Colors.green : Colors.red,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
