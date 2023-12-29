import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/BOTTOM_BAR/nav_bar.dart';
import 'package:service_provider/WIDGETS/extra-services.dart';
import 'package:service_provider/WIDGETS/search.dart';
import 'package:service_provider/WIDGETS/services.dart';
import 'package:service_provider/WIDGETS/trending.dart';
import 'package:service_provider/login-signup/signup.dart';
import 'package:service_provider/provider/user_state_provider.dart';

class Home extends StatelessWidget {
  final Map<String, dynamic> user;

  const Home({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('Service Provider'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Builder(builder: (context) {
                  return Text(
                      'Name: ${Provider.of<UserStateProvider>(context).user['name']}');
                }),
              ),
              PopupMenuItem(
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<UserStateProvider>(context, listen: false)
                          .logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                          (Route<dynamic> route) => false);
                    },
                    child: Row(
                      children: [Text('Logout'), Icon(Icons.logout)],
                    ),
                  );
                }),
              )
            ],
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(child: Searching()),
                  SliverToBoxAdapter(child: SizedBox(height: 30)),
                  Service(),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Trending Now',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Trending(),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Looking for something else?',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ExtraService(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: NavBar(
                  currentIndex: 0,
                  onTap: (index) {
                    if (index == 1) {
                      Navigator.pushNamed(context, 'task');
                    } else if (index == 2) {
                      Navigator.pushNamed(context, 'profile');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
