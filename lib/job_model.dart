import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JobModel {
  JobModel({
    required this.id,
    required this.title,
    required this.type,
    required this.position,
    required this.description,
    required this.salaryRange,
    required this.salaryInterval,
    required this.postedDate,
    required this.company,
  });

  final int id;
  final String title;
  final String type;
  final String position;
  final String description;
  final List<double> salaryRange;
  final String salaryInterval;
  final Company company;
  final String postedDate;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JobModel &&
        other.id == id &&
        other.title == title &&
        other.type == type &&
        other.position == position &&
        other.description == description &&
        listEquals(other.salaryRange, salaryRange) &&
        other.salaryInterval == salaryInterval &&
        other.company == company &&
        other.postedDate == postedDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        type.hashCode ^
        position.hashCode ^
        description.hashCode ^
        salaryRange.hashCode ^
        salaryInterval.hashCode ^
        company.hashCode ^
        postedDate.hashCode;
  }
}

class Company {
  Company({
    required this.name,
    required this.location,
    this.backgroundColor,
  });

  final String name;
  final String location;
  final Color? backgroundColor;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company && other.name == name && other.location == location;
  }

  @override
  int get hashCode => name.hashCode ^ location.hashCode;
}
