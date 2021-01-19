import 'package:equatable/equatable.dart';

// 登录事件
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// 登录按钮按下事件
class LoginPressEvent extends LoginEvent {
  final String name;
  final String pwd;

  LoginPressEvent(this.name, this.pwd);

  @override
  List<Object> get props => [name, pwd];
}
