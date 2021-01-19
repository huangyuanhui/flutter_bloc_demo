import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/login_bloc.dart';
import 'package:flutter_bloc_demo/bloc/login_state.dart';

// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 登录业务逻辑
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    // 获取
    loginBloc =  BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录成功的页面'),
        centerTitle: true,
      ),
      body: BlocBuilder<LoginBloc,LoginState>(
        builder: (context,state){
          if(state is LoginSuccessState){
            // 状态是登录成功状态
            final currentState = state;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('登录成功',style: TextStyle(fontSize: 24,color: Colors.black),),
                SizedBox(height: 10,),
                Text('登录账号::::${state.model.name}',style: TextStyle(fontSize: 18,color: Colors.black),),
                SizedBox(height: 10,),
                Text('登录密码::::${state.model.pwd}',style: TextStyle(fontSize: 18,color: Colors.black),),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}