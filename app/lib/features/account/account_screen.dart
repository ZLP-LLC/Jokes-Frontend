import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:zlp_jokes/features/account/cubit/account_cubit.dart';
import 'package:zlp_jokes/features/account/cubit/account_screen_states.dart';
import 'package:zlp_jokes/features/account/widgets/login_widget.dart';
import 'package:zlp_jokes/features/account/widgets/register_widget.dart';

import 'package:zlp_jokes/utils/app_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountScreenCubit()..init(),
      child: BlocConsumer<AccountScreenCubit, AppState>(
        listener: (context, state) {
          if (state is AppStateError) {
            // Fluttertoast.showToast(
            //   msg: state.message,
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.CENTER,
            //   timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.black,
            //   textColor: Colors.white,
            //   fontSize: 16.0,
            // );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AppStateLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case AccountScreenStateLogIn:
              return LoginWidget();
            case AccountScreenStateRegister:
              return RegisterWidget();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
