import 'package:flutter/material.dart';

class PerssonalListScreen extends StatefulWidget {
  const PerssonalListScreen({super.key});

  @override
  State<PerssonalListScreen> createState() => _PerssonalListScreenState();
}

class _PerssonalListScreenState extends State<PerssonalListScreen> {
  String status = 'inactive';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset("assets/images/Frame2.png", fit: BoxFit.fill),
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
              ],
            ),
          ),
          SizedBox(height: 15),
          detailsCard(
            status: "active",
            name: "Arun",
            phone: "956321477410",
            role: "Land owner",
            address: "Villa no.13, banglore, karnataka, india, 675643",
          ),
          SizedBox(height: 15),
          detailsCard(
            status: "inactive",
            name: "Arun",
            phone: "956321477410",
            role: "Land owner",
            address: "Villa no.13, banglore, karnataka, india, 675643",
          ),
          SizedBox(height: 15),
          detailsCard(
            status: "inactive",
            name: "Arun",
            phone: "956321477410",
            role: "Land owner",
            address: "Villa no.13, banglore, karnataka, india, 675643",
          ),
          SizedBox(height: 15),
          detailsCard(
            status: "active",
            name: "Arun",
            phone: "956321477410",
            role: "Land owner",
            address: "Villa no.13, banglore, karnataka, india, 675643",
          ),
        ],
      ),
    );
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
                  child: Icon(Icons.group, color: Colors.black87),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
