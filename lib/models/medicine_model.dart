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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'medicine_model.freezed.dart';
part 'medicine_model.g.dart';

@freezed
class MedicineModel with _$MedicineModel {
  const factory MedicineModel({
    required String m1,
    required String m2,
    required String m3,
    required String m4,
    required String m5,
    required String m6,
    required String m7,
  }) = _MedicineModel;

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
}
