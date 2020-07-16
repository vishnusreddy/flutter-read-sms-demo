import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:super_sms/first_screen.dart';
import 'login_page.dart';
import 'sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class Message extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyInbox(),
    );
  }
}

class MyInbox extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return MyInboxState();
  }
}

class MyInboxState extends State {
  SmsQuery query = new SmsQuery();
  List messages = new List();
  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text("Messages"),
            backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  //signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return FirstScreen();
                  }), ModalRoute.withName('/'));
                },
              ),
            ]),
        body: FutureBuilder(
          future: fetchSMS(),
          builder: (context, snapshot) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.lightBlueAccent,
                        size: 45.0,
                      ),
                      title: Text(
                        messages[index].address,
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 20.0,
                        ),
                      ),
                      subtitle: Text(
                        messages[index].body,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black,
                        fontSize: 15),
                      ),
                      onTap: () {
                        //This should display that message
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SecondRoute(text: messages[index].body)),
                        );
                      },
                    ),
                  );
                });
          },
        ));
  }

  fetchSMS() async {
    messages = await query.getAllSms;
  }
}

class SecondRoute extends StatelessWidget {
  final String text;

  // receive data from the FirstScreen as a parameter
  SecondRoute({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Full Message"),
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        );
  }
}
