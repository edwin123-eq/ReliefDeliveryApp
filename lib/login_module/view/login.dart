import 'package:deliveryapp/View/main_screen/main_screen.dart';
import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:deliveryapp/blocs/bloc/licence%20bloc/license_event.dart';
import 'package:deliveryapp/blocs/bloc/login%20bloc/login_bloc.dart';
import 'package:deliveryapp/blocs/bloc/login%20bloc/login_event.dart';
import 'package:deliveryapp/blocs/bloc/login%20bloc/login_state.dart';
import 'package:deliveryapp/login_module/controller/repo.dart';
import 'package:deliveryapp/widgets/loading_indicator.dart';
import 'package:deliveryapp/widgets/loading_overlay.dart';
import 'package:deliveryapp/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  LoadingOverlay loadingOverlay = LoadingOverlay();
  @override
  void initState() {
    super.initState();
    // _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveData = ResponsiveData.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // Show loading indicator
            // LoadingWidget();
          } else if (state is LoginSuccess) {
            // Hide loading indicator and navigate
            loadingOverlay.hide();
            if (state.response.accessToken.isNotEmpty) {
              snackBarWidget(
                      msg: "Login is successful",
                      icons: Icons.warning_amber,
                      iconcolor: Colors.green,
                      texcolor: Colors.green,
                      backgeroundColor: Colors.white,
                      context: context)
                  .then((val) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              });
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text("Login is successful")),
              // );
            } else {
              loadingOverlay.hide();

              snackBarWidget(
                  msg: "Login Failed",
                  icons: Icons.warning_amber,
                  iconcolor: Colors.red,
                  texcolor: Colors.red,
                  backgeroundColor: Colors.white,
                  context: context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text("Something Went Wrong")),
              // );
            }

            /// Navigator.pop(context); // Hide loading dialog
          } else if (state is LoginFailure) {
            loadingOverlay.hide();
            // Hide loading indicator and show error
            // Hide loading dialog
            snackBarWidget(
                msg: "Login Failed",
                icons: Icons.warning_amber_rounded,
                iconcolor: Colors.red,
                texcolor: Colors.red,
                backgeroundColor: Colors.white,
                context: context);
          } else {
            loadingOverlay.hide();
          }
        },
        child: Container(
          width: responsiveData.screenWidth,
          height: responsiveData.screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: responsiveData.screenWidth,
                    // height: responsiveData.screenHeight * .55,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.all(responsiveData.screenWidth * .10),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // LoadingWidget(),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.logo,
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Relief Medicals',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.Bottomnav,
                              ),
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              'Username',
                              Icons.person,
                              _usernameController,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              'Password',
                              Icons.lock,
                              _passwordController,
                              obscureText: !_isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                final username = _usernameController.text;
                                final password = _passwordController.text;

                                if (username.isNotEmpty &&
                                    password.isNotEmpty) {
                                  loadingOverlay.show(context);

                                  final loginBloc =
                                      BlocProvider.of<LoginBloc>(context);

                                  loginBloc.add(LoginSubmitted(
                                    username: username,
                                    password: password,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill all fields'),
                                    ),
                                  );
                                }
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final responsiveData = ResponsiveData.of(context);
    return SizedBox(
      width: responsiveData.screenWidth * .75,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          filled: true,
          fillColor: Colors.blue.shade50,
        ),
      ),
    );
  }
}
