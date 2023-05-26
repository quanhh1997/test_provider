// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Manager with ChangeNotifier {
  late List<Model> listModel;
  int selected;
  Manager({this.selected = 0});

  void genarateData() {
    List<Model> data = [];
    for (var i = 0; i < 10; i++) {
      data.add(Model(index: i, title: 'title $i', value: 0.4));
    }
    listModel = data;
  }

  void selectItem(int index) {
    selected = index;
    notifyListeners();
  }

  void changeValue(double value) {
    listModel[selected].value = value;
    notifyListeners();
  }
}

class Model {
  int index;
  String title;
  double value;
  Model({
    required this.index,
    required this.title,
    required this.value,
  });

  Model copyWith({
    int? index,
    String? title,
    double? value,
  }) {
    return Model(
      index: index ?? this.index,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'title': title,
      'value': value,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      index: map['index'] as int,
      title: map['title'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) =>
      Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Model(index: $index, title: $title, value: $value)';

  @override
  bool operator ==(covariant Model other) {
    if (identical(this, other)) return true;

    return other.index == index && other.title == title && other.value == value;
  }

  @override
  int get hashCode => index.hashCode ^ title.hashCode ^ value.hashCode;
}
