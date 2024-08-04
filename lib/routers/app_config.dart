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
import 'package:go_router/go_router.dart';
import 'package:medicine_schedule/models/models.dart';
import 'package:medicine_schedule/routers/routes.dart';
import 'package:medicine_schedule/screens/screens.dart';

class AppConfig {
  final GoRouter _router;

  AppConfig()
      : _router = GoRouter(
          routes: [
            GoRoute(
              name: '/',
              path: '/',
              builder: (context, state) {
                return const FormLoginScreen();
              },
            ),
            GoRoute(
              name: AppConstanst.dashboardScreen,
              path: AppConstanst.dashboardScreen,
              builder: (context, state) {
                return const DashboardScreen();
              }
            ),
            GoRoute(
              name: AppConstanst.formScheduleScreen,
              path: AppConstanst.formScheduleScreen,
              builder: (context, state) {
                return const FormScheduleScreen();
              },
            ),
            GoRoute(
              name: AppConstanst.formMedicineScreen,
              path: AppConstanst.formMedicineScreen,
              builder: (context, state) {
                return FormMedicineScreen(
                  medicineModel: state.extra as List<MedicineModel>,
                );
              },
            )
          ],
          errorBuilder: (context, state) {
            return const Scaffold(
              body: Center(
                child: Text('Halaman tidak ditemukan'),
              ),
            );
          },
        );

  GoRouter get router => _router;
}
