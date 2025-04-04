import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      // Log out
      EncryptedSharedPreferences.getInstance().remove("token");
      final authCubit = BlocProvider.of<AppUserCubit>(context).updateUser(null);
    }, child: Text("Log Out"));
  }
}
