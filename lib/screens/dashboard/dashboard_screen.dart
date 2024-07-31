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

class DashboardScreen extends StatelessWidget {
  final Function(BuildContext context) onPressedAddSchedule;

  const DashboardScreen({
    required this.onPressedAddSchedule,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardScreenContent(
      onPressedAddSchedule: onPressedAddSchedule,
    );
  }
}

class DashboardScreenContent extends StatefulWidget {
  final Function(BuildContext context) onPressedAddSchedule;
  const DashboardScreenContent({
    required this.onPressedAddSchedule,
    super.key,
  });

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              children: [Text('Daftar Schedule')],
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
                onPressed: () {
                  widget.onPressedAddSchedule(context);
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
