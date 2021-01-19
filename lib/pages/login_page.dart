import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/login_bloc.dart';
import 'package:flutter_bloc_demo/bloc/login_event.dart';
import 'package:flutter_bloc_demo/bloc/login_state.dart';
import 'package:flutter_bloc_demo/pages/home_page.dart';

// 登录页
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// 登录页状态
class _LoginPageState extends State<LoginPage> {
  final nameCtr = new TextEditingController();
  final pwdCtr = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // 控制器添加监听
    nameCtr.addListener(() {
      print('name输入框的实时变化::::${nameCtr.text}');
    });
    // 控制器添加监听
    pwdCtr.addListener(() {
      print('pwd输入框的实时变化::::${pwdCtr.text}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameCtr?.removeListener(() {});
    nameCtr?.dispose();
    pwdCtr?.removeListener(() {});
    pwdCtr?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            // 状态为LoginInitialState 返回登录界面
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 用户名
                nameTF(),
                // 密码
                pwdTF(),
                // 登录按钮
                loginBtn(context, () {
                  // 点击事件，bloc添加事件/动作 事件再映射成状态 状态再显示出来
                  BlocProvider.of<LoginBloc>(context).add(
                      LoginPressEvent(nameCtr.text.trim(), pwdCtr.text.trim()));
                }),
              ],
            );
          }

          if (state is LoginInProgressState) {
            // 状态为LoginInProgressState 返回登录Progress
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoginSuccessState) {
            // 状态为LoginSuccessState 显示成功Dialog
            return SuccessDialog();
          }

          if (state is LoginFailureState) {
            // 状态为LoginFailureState 显示错误信息
            final currentState = state;
            return Center(
              child: Text(
                currentState.errMsg,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            );
          }
          // 默认返回
          return Container();
        },
      ),
    );
  }

  // 账号输入框
  Widget nameTF() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: TextField(
        controller: nameCtr,
        decoration: InputDecoration(
            fillColor: Color(0x30cccccc),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x00FF0000)),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x00FF0000)),
                borderRadius: BorderRadius.circular(100)),
            hintText: '请输入用户名'),
      ),
    );
  }

  // 密码输入框
  Widget pwdTF() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      width: double.infinity,
      child: TextField(
        controller: pwdCtr,
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          hintText: '请输入密码',
        ),
        obscureText: true,
      ),
    );
  }

  // 登录按钮
  Widget loginBtn(context, onPressed) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          '登录',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        // 点击，回调方法
        onPressed: onPressed,
      ),
    );
  }
}

// 登录成功显示的对话框
class SuccessDialog extends StatefulWidget {
  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  // 等5秒 跳转到HomePage
  Future<void> waitFuture() async {
    await Future.delayed(Duration(milliseconds: 5000));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void initState() {
    super.initState();
    // 等5秒 跳转到HomePage
    waitFuture();
  }

  // 对话框界面
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '登录成功',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
