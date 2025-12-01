import 'package:beechem/bloc/bloc/personaldetailsadd_bloc.dart';
import 'package:beechem/bloc/bloc/personaldetailslist_bloc.dart';
import 'package:beechem/models/personaldetails/personaldetails.dart';
import 'package:beechem/repository/apiservices.dart';
import 'package:beechem/screens/personal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerssonalListScreen extends StatefulWidget {
  const PerssonalListScreen({super.key});

  @override
  State<PerssonalListScreen> createState() => _PerssonalListScreenState();
}

class _PerssonalListScreenState extends State<PerssonalListScreen> {
  String status = 'inactive';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    final nav = Navigator.of(context);
    return BlocProvider(
      create: (context) =>
          PersonaldetailslistBloc(apiServices)
            ..add(CallPersonalDetailsApiEvent()),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F7F9),
        body: SingleChildScrollView(
          child: Column(
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
                      'Personnel Details List',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              BlocBuilder<PersonaldetailslistBloc, PersonaldetailslistState>(
                builder: (context, state) {
                  if (state is PersonaldetailslistLoading) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: CircularProgressIndicator(
                          color: Colors.brown[900],
                        ),
                      ),
                    );
                  }
                  if (state is PersonaldetailslistFailure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Text("No Data Found"),
                      ),
                    );
                  }
                  if (state is PersonaldetailslistSuccess) {
                    // List<Data> contacts = state.data?.data ?? [];

                    List<Data> allContacts = state.data?.data ?? [];
                    List<Data> contacts = searchQuery.isEmpty
                        ? allContacts
                        : allContacts.where((c) {
                            final name = (c.firstName ?? '')
                                .toString()
                                .toLowerCase();
                            return name.contains(searchQuery.toLowerCase());
                          }).toList();

                    return Column(
                      children: [
                        SizedBox(height: 15),
                        // search bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 12,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: "Search...",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchQuery = searchController.text
                                          .trim();
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.amber, // yellow
                                    child: Text(
                                      "GO",
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (contacts.isEmpty) ...{
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text('No results for "$searchQuery"'),
                          ),
                        },
                        SizedBox(height: 15),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                detailsCard(
                                  status: contacts[index].status == "1"
                                      ? "active"
                                      : "inactive",
                                  name: contacts[index].firstName ?? '',
                                  phone: contacts[index].contactNumber ?? '',
                                  role: contacts[index].roleDetails!.isNotEmpty
                                      ? contacts[index]
                                                .roleDetails
                                                ?.first
                                                .role ??
                                            ''
                                      : '',
                                  address: contacts[index].address ?? '',
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          },
                          itemCount: contacts.length,
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nav.push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider(
                      create: (context) => PersonaldetailsaddBloc(apiServices),
                      child: const PersonalDetailsScreen(),
                    ),
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
          },
          backgroundColor: Colors.amber,
          child: Icon(Icons.add, color: Colors.brown[900], size: 42),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

// card widget
Widget detailsCard({
  required String status,
  required String name,
  required String phone,
  required String role,
  required String address,
}) {
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
    child: Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide.none,
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 24,
                  child: Icon(Icons.group_outlined, color: Colors.black87),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              color: status == 'active'
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: status == 'active'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            child: SizedBox(
                              height: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "•", // bold dot
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: status == 'active'
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                    ),
                                  ),

                                  SizedBox(width: 5),
                                  Text(
                                    status == 'active' ? "Active" : "Inactive",
                                    style: TextStyle(
                                      color: status == 'active'
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey[700]),

                          SizedBox(width: 6),

                          Text(
                            phone,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),

                          SizedBox(width: 10),

                          Text(
                            "•", // bold dot
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),

                          SizedBox(width: 10),

                          Icon(
                            Icons.person_3_rounded,
                            size: 18,
                            color: Colors.grey[700],
                          ),

                          SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              role,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Divider(thickness: 1, color: Colors.grey.shade300, height: 0),

            SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_sharp, size: 16, color: Colors.grey),

                SizedBox(width: 6),

                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
