import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/login_event.dart';
import 'package:flutter_bloc_demo/bloc/login_repository.dart';
import 'package:flutter_bloc_demo/bloc/login_state.dart';
import 'package:flutter_bloc_demo/model/user_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // 初始化状态为LoginInitialState
  @override
  LoginState get initialState => LoginInitialState();

  //   事件/动作 映射 状态/数据
  // 事件映射成状态，状态在View中显示
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginPressEvent) {
        // 事件/动作是登录按钮按下
        UserModel model = UserModel.init();
        // 状态转为：登陆中
        yield LoginInProgressState();
        final currentEvent = event;
        // 获取用户数据模型
        model = await LoginRepository.login(
            currentEvent.name.trim(), currentEvent.pwd.trim());
        // 状态转为：登录成功 View（即LoginPage）中显示对应界面
        yield LoginSuccessState(model);
      }
    } catch (e) {
      final errMsg = '登录错误';
      yield LoginFailureState(errMsg);
    }
  }
}
