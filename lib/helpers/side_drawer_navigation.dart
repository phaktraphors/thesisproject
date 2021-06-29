import 'package:flutter/material.dart';
import 'package:kate_botique_app/screen/login_screen.dart';

class SideDrawerNavigation extends StatefulWidget {
  @override
  _SideDrawerNavigationState createState() => _SideDrawerNavigationState();
}

class _SideDrawerNavigationState extends State<SideDrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.withOpacity(0.10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: DrawerHeader(
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 90,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text("PHORS PHAKTRA",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        )),
                    Text("phorsphaktra@gmail.com",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w900))
                  ],
                ),
              ),
            ),
//
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.person_sharp),
                    title:
                        Text('Proflie', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.category),
                    title:
                        Text('Category', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.pending_actions_sharp),
                    title: Text('Brand', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('Shop', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0),
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Login', style: TextStyle(color: Colors.black)),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
