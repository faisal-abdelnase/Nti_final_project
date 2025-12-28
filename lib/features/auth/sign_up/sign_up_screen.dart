import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nti_final_project/core/helper/extensions.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/features/auth/cubit/auth_cubit.dart';
import 'package:nti_final_project/widgets/custom_button.dart';
import 'package:nti_final_project/widgets/custom_text_feild.dart';

class SignUpScreen extends StatefulWidget {
  
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccsess) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Register Successfully..',
                style: TextStyle(color: Colors.white),)
              )
            );
            context.pushNamed(Routes.chatsConversation);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errMessage,
                style: TextStyle(color: Colors.white),)
              )
            );
          }
        },
        builder: (context, state) {
          final myCubit = context.read<AuthCubit>();

          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManagers.primaryColor,
              ),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        SizedBox(width: width * 0.21),
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
                        if(_formKey.currentState!.validate()){
                          myCubit.signUp(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                        );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
