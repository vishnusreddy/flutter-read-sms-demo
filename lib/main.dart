import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/contact.dart';
import 'package:sms/sms.dart';
import 'package:super_sms/first_screen.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic/neumorphic.dart';

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
  ContactQuery contacts = new ContactQuery();
  List<String> cname = new List();
  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
                        size: 60.0,
                      ),
                      title:
                      FutureBuilder(
                        future:
                        name(messages[index].address),
                        builder: (context,snapshot){
                          return Text(
                            cname[index],style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 20.0,
                          ),
                          );
                        },
                      ),/*
                      Text(
                        //cname[index],
                        messages[index].address,
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 20.0,
                        ),
                      ),*/
                      subtitle: Text(
                        messages[index].body,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      trailing: Text(
                        DateFormat('h:mm a').format(messages[index].date),
                        //messages[index].body,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onTap: () {
                        //This should display that message
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SecondRoute(message: messages[index])),
                        );
                      },
                    ),
                  );
                });
          },
        ));
  }

  name(address) async {
    Contact contact = await contacts.queryContact(address);
    if (contact.fullName != null) {
      cname.add(contact.fullName);

    } else {
      cname.add(address);
    }
  }


  fetchSMS() async {
    messages = await query.getAllSms;
  }
}

class SecondRoute extends StatelessWidget {
  final SmsMessage message;

  // receive data from the FirstScreen as a parameter
  SecondRoute({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Message"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Text(
          "FROM:"+"\n"+message.address+"\n\nAT:"+"\n"+DateFormat('EEE, MMM d,h:mm a').format(message.date)+"\n"+"\n"+message.body+"\n"+"\n",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
