import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('G-Login'), actions: <Widget>[
          FutureBuilder(
            future: googleSignIn
                .isSignedIn(), // Checks whether user is already logged in or not
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data) {
                  // already logged in
                  return IconButton(
                      icon: Icon(Icons.block),
                      onPressed: () async {
                        try {
                          await googleSignIn.signOut();
                          setState(() {});
                        } catch (error) {}
                      });
                } else {
                  // no user logged in
                  return IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () async {
                        await googleSignIn.signIn();
                        setState(() {});
                      });
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ]),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('hi ${googleSignIn.currentUser?.displayName}!!'),
              FutureBuilder(
                future: googleSignIn.currentUser?.authentication,
                builder:
                    (_, AsyncSnapshot<GoogleSignInAuthentication> snapShot) {
                  return snapShot.connectionState == ConnectionState.done
                      ? (snapShot.hasData
                      ? Text('id-token, ${snapShot.data.idToken}')
                      : Text('Ooops something went wrong'))
                      : Text('loading....');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
class MyApp extends StatelessWidget {
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
class MyInbox extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return MyInboxState();
  }

}

class MyInboxState extends State{
  SmsQuery query = new SmsQuery();
  List messages=new List();
  @override
  initState()  {
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
        ),
        body: FutureBuilder(
          future: fetchSMS() ,
          builder: (context, snapshot)  {

            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                itemCount: messages.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.message,color: Colors.lightBlueAccent,size: 45.0,),
                      title: Text(messages[index].address,style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 20.0,
                      ),),
                      subtitle: Text(messages[index].body,maxLines:2,style: TextStyle(color: Colors.black),),
                    onTap: (){
                        //This should display that message
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute(text:messages[index].body)),
                      );
                    },
                    ),
                  );
                });
          },)
    );
  }

  fetchSMS()
  async {
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
          text,style:TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
 */