import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/model/user_model.dart';

// 登录状态
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

// 登录初始化
class LoginInitialState extends LoginState{}

// 登录中
class LoginInProgressState extends LoginState{}

// 登录成功
class LoginSuccessState extends LoginState{
  // 状态持有数据模型
  final UserModel model;

  LoginSuccessState(this.model);

  @override
  List<Object> get props => [model];
}

// 登录失败
class LoginFailureState extends LoginState{
  final String errMsg;

  LoginFailureState(this.errMsg);

  @override
  List<Object> get props => [errMsg];
}