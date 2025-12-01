import 'package:beechem/bloc/bloc/login_bloc.dart';
import 'package:beechem/repository/apiservices.dart';
import 'package:beechem/screens/personal_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  String? emailError;
  String? passwordError;
  bool isPasswordVisible = false;

  bool validate() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      // Email
      if (email.isEmpty) {
        emailError = "Email is required";
      } else if (!RegExp(
        r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,4}$',
      ).hasMatch(email)) {
        emailError = "Invalid email address";
      } else {
        emailError = null;
      }

      // Password
      if (password.isEmpty) {
        passwordError = "Password is required";
      } else if (password.length < 6) {
        passwordError = "Password must be at least 6 characters";
      } else {
        passwordError = null;
      }
    });

    return emailError == null && passwordError == null;
  }

  @override
  void initState() {
    super.initState();
    loadSavedEmail();
  }

  void loadSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("saved_email");
    bool? savedCheck = prefs.getBool("is_remembered");

    if (savedEmail != null && savedCheck == true) {
      emailController.text = savedEmail;
      setState(() {
        isChecked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    final nav = Navigator.of(context);
    return BlocProvider(
      create: (context) => LoginBloc(apiServices),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                "access_token",
                state.data?.accessToken ?? '',
              );
              showCustomSnackBar(
                context: context,
                message: "Successfull Login",
                isSuccess: true,
              );
            
              nav.pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const PerssonalListScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        // Fade + Slide from right
                        final fadeAnim = Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation);
                        final slideAnim =
                            Tween<Offset>(
                              begin: const Offset(1, 0), // from right
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            );

                        return FadeTransition(
                          opacity: fadeAnim,
                          child: SlideTransition(
                            position: slideAnim,
                            child: child,
                          ),
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              return;
            } else if (state is LoginFailure) {
              showCustomSnackBar(
                context: context,
                message: "Login Failed",
                isSuccess: false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        "assets/images/Frame1.png",
                        width: double.infinity,
                        height: 330,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 128,
                        child: Image.asset(
                          "assets/images/Vector.png",
                          width: 82,
                          height: 82,
                        ),
                      ),
                      Positioned(
                        top: 218,
                        child: Text(
                          'BEE CHEM',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 43),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      height: 2.5,
                      fontSize: 16,
                      color: Color(0xFF8A8A8A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 30),
                  inputField(
                    hintText: 'Email address',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: Color(0xFF8A8A8A),
                    ),
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  (emailError != null)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              emailError!,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),

                  SizedBox(height: 10),
                  inputField(
                    hintText: 'password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 30,
                      color: Color(0xFF8A8A8A),
                    ),
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    obscureText: isPasswordVisible,
                  ),
                  (passwordError != null)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              passwordError!,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          fillColor: WidgetStateProperty.all(Colors.amber),
                          activeColor: Colors.white,
                          side: BorderSide(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text("Remember me"),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "FORGOT PASSWORD?",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Login Button
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.amber[400],
                              ),
                            ),
                            onPressed: () async {
                              if (!validate()) return;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              if (isChecked) {
                                await prefs.setString(
                                  "saved_email",
                                  emailController.text,
                                );
                                await prefs.setBool("is_remembered", true);
                              } else {
                                await prefs.remove("saved_email");
                                await prefs.setBool("is_remembered", false);
                              }

                              if (!mounted) return;

                              context.read<LoginBloc>().add(
                                CallLoginApiEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.brown[900],
                              ),
                            ),
                          ),
                        ),
                      ),
                      (state is LoginLoading)
                          ? CircularProgressIndicator(color: Colors.brown[900])
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 10,
                          indent: 20,
                          endIndent: 5,
                        ),
                      ),
                      Text("OR"),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 10,
                          indent: 5,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'REGISTER',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget inputField({
  required String hintText,
  required Icon prefixIcon,
  required TextEditingController controller,
  required TextInputType textInputType,
  bool? obscureText,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Stack(
      children: [
        SizedBox(width: double.infinity, height: 68),
        Positioned(
          left: 0,
          right: 0,
          top: 6,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              obscureText: !(obscureText ?? true),
              keyboardType: textInputType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Color(0xFF8A8A8A), fontSize: 16),
                contentPadding: EdgeInsets.only(
                  top: 7,
                  bottom: 20,
                  left: 80, // text starts after the icon
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Color(0xFFF4C714), width: 1.5),
                ),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(0), // border thickness
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // change to your preferred color
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: prefixIcon,
          ),
        ),
      ],
    ),
  );
}

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required bool isSuccess,
}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          isSuccess ? Icons.check_circle : Icons.error,
          color: Colors.brown[900],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.brown[900],
            ),
          ),
        ),
      ],
    ),
    backgroundColor: isSuccess ? Colors.amber[100] : Colors.red[100],
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    duration: const Duration(seconds: 2),
    elevation: 6,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
