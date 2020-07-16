import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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