import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/core/helper/extensions.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/cubits/auth_cubit.dart';
import 'package:nti_final_project/cubits/auth_state.dart';
import 'package:nti_final_project/widgets/custom_button.dart';
import 'package:nti_final_project/widgets/custom_text_feild.dart';

class LoginScreen extends StatelessWidget {
  // static const String routeName = 'Login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SuccsessAuthState) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Login Successfully..',
                style: TextStyle(color: Colors.white),)
              )
            );
          context.pushNamed(Routes.chatsConversation);
        }
        if (state is ErrorAuthState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Invaild Input..',
                style: TextStyle(color: Colors.white),)
              )
            );
          }
        },
        builder: (context, state) {
          final mycubit = context.read<AuthCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.27,
                    decoration: BoxDecoration(color: ColorManagers.secondryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Login', style: StyleManagers.font35White700),
                              SizedBox(width: width * 0.42),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      50,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  iconColor: Colors.white,
                                ),
                                onPressed: () {
                                  context.pushNamed(Routes.signUpScreen);
                                },
                                child: Text(
                                  'Register',
                                  style: StyleManagers.font18PrimColor600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.04),
                          Text(
                            'Enter your Email\n and Passsword',
                            style: StyleManagers.font32White500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 0.08,
                    decoration: BoxDecoration(color: ColorManagers.blueIceColor),
                  ),
                  SizedBox(height: height * 0.05),
                  CustomTextFeild(
                    text: 'Email',
                    iconData: Icons.email,
                    textEditingController: emailController,
                  ),
                  SizedBox(height: height * 0.05),
                  CustomTextFeild(
                    text: 'Password',
                    iconData: Icons.lock,
                    textEditingController: passwordController,
                  ),
                  SizedBox(height: height * 0.08),
                  CustomButton(
                    name: 'Login',
                    onTap: () {
                      mycubit.login(
                        emailController.text,
                        passwordController.text
                        );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
