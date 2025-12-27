import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nti_final_project/core/helper/extensions.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/cubits/auth_cubit.dart';
import 'package:nti_final_project/cubits/auth_state.dart';
import 'package:nti_final_project/widgets/custom_button.dart';
import 'package:nti_final_project/widgets/custom_text_feild.dart';

class SignUpScreen extends StatelessWidget {
  // static const String routeName = 'SignUp';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
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
                content: Text('Register Successfully..',
                style: TextStyle(color: Colors.white),)
              )
            );
            context.pushNamed(Routes.signUpScreen);
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
          final myCubit = context.read<AuthCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: OvalBottomBorderClipper(),
                        child: Container(
                          height: height * 0.38,
                          color: ColorManagers.blueIceColor,
                        ),
                      ),
                      ClipPath(
                        clipper: OvalBottomBorderClipper(),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.32,
                          decoration: BoxDecoration(
                            color: ColorManagers.secondryColor,
                          ),
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.03,
                                left: width * 0.05,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  50,
                                                ),
                                          ),
                                          padding: EdgeInsets.all(15),
                                          iconColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          context.pushNamed(Routes.loginScreen);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_back,
                                              color: ColorManagers.primaryColor,
                                              size: 23,
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Text(
                                              'Login',
                                              style: StyleManagers
                                                  .font18PrimColor600,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: width * 0.23),
                                      Text(
                                        'Register',
                                        style: StyleManagers.font35White700,
                                      ),
                                      const SizedBox(width: 50),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.03,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 65,
                                          backgroundColor: Colors.blue.shade200,
                                          child: Icon(
                                            Icons.person,
                                            size: 90,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Color(0xFF1A4594),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  CustomTextFeild(
                    text: 'name',
                    iconData: Icons.person,
                    textEditingController: nameController,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFeild(
                    text: 'Email',
                    iconData: Icons.email,
                    textEditingController: emailController,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFeild(
                    text: 'password',
                    iconData: Icons.lock,
                    textEditingController: passwordController,
                  ),
                  SizedBox(height: height * 0.05),
                  CustomButton(
                    name: 'Register',
                    onTap: () {
                      myCubit.register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
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
