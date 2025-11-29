import 'package:beechem/screens/personal_list_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  fillColor: WidgetStateProperty.all(Colors.amber),
                  activeColor: Colors.black,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.amber[400]),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PerssonalListScreen()));
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
        ],
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
          child: TextField(
            controller: controller,
            obscureText: obscureText ?? false,
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
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: Color(0xFFF4C714), width: 1.5),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(0), // border thickness
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey, // change to your preferred color
              width: 2,
            ),
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
