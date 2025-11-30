import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController suburb = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController additionalNotes = TextEditingController();
  bool isActive = false;

  List<String> roles = ["Colony Owner", "Chem Applicator", "Land Owner"];

  // map to store checked values
  Map<String, bool> selectedRoles = {};

  @override
  void initState() {
    super.initState();
    // initialize all values to false
    for (var role in roles) {
      selectedRoles[role] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/Frame2.png", fit: BoxFit.fill),
                Positioned(
                  top: 70,
                  right: 22,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_3_rounded,
                      size: 23,
                      color: Colors.brown[900], // choose any color you want
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 22,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.grid_view_outlined,
                      size: 23,
                      color: Colors.brown[900], // choose any color you want
                    ),
                  ),
                ),

                Positioned(
                  top: 115,
                  child: Text(
                    'Personnel Details',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            formInputField(
              controller: fullName,
              label: "Full name",
              hintText: "Please type",
            ),
            SizedBox(height: 15),
            formInputField(
              controller: address,
              label: "Address",
              hintText: "Please type",
              prefixIcon: Icon(
                Icons.location_on_outlined,
                size: 23,
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.my_location_outlined,
                size: 23,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            formInputField(
              controller: suburb,
              label: "Suburb",
              hintText: "Please type",
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: formInputField(
                      controller: state,
                      label: "State",
                      hintText: "Please type",
                      horizontalPadding: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: formInputField(
                      controller: postCode,
                      label: "Post code",
                      hintText: "Please type",
                      horizontalPadding: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            formInputField(
              controller: contact,
              label: "Contact",
              hintText: "Please type",
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Role",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide.none,
              ),
              color: Colors.white,
              child: Column(
                children: roles.map((role) {
                  return Row(
                    children: [
                      Checkbox(
                        value: selectedRoles[role],
                        activeColor: Colors.amber,
                        onChanged: (bool? value) {
                          setState(() {
                            selectedRoles[role] = value!;
                          });
                        },
                      ),
                      Text(role, style: TextStyle(fontSize: 16)),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 15),

            formInputField(
              controller: additionalNotes,
              label: "Additional Notes",
              hintText: "Please type",
              maxLines: 5,
              maxLength: 500,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 55,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    CupertinoSwitch(
                      value: isActive,
                      onChanged: (bool value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                      activeColor: Colors.green,
                      trackColor: Colors.grey,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.grey[350],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown[900],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 60),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.amber[400],
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}

Widget formInputField({
  required TextEditingController controller,
  required String label,
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double? horizontalPadding,
  int? maxLines,
  int? maxLength,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 16),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxLines,
            maxLength: maxLength,
          ),
        ),
      ],
    ),
  );
}
