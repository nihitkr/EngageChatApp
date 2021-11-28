import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage_chat_app/helper/constants.dart';
import 'package:engage_chat_app/helper/database.dart';
import 'package:engage_chat_app/models/user_model.dart';
import 'package:engage_chat_app/screens/chatRoomScreen.dart';
import 'package:engage_chat_app/screens/loginScreen.dart';
import 'package:engage_chat_app/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  static void logout(BuildContext context) {}
}

class _HomeScreenState extends State<HomeScreen> {
  User? users = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String firstName = DatabaseMethods.firstName;
  String lastName = DatabaseMethods.lastName;

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(users!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Screen"),
        actions: [
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          );
        },
        child: Icon(
          Icons.search,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/welcome.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                // "${firstName} ${lastName}",
                Constants.myName,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${loggedInUser.email}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),

              //Enter Chat Room
              ActionChip(
                backgroundColor: Colors.redAccent,
                label: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter Chat Room ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.message_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(),
                    ),
                  );
                },
              ),

              //Logout
              ActionChip(
                backgroundColor: Colors.redAccent,
                label: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logout ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Logout Function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}
