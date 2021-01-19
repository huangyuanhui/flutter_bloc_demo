import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// 用户模型
class UserModel extends Equatable {
  final String name;
  final String pwd;

  UserModel({@required this.name, @required this.pwd})
      : assert(name != null, pwd != null);

  factory UserModel.init() {
    return UserModel(name: '', pwd: '');
  }

  @override
  List<Object> get props => [name, pwd];
}
