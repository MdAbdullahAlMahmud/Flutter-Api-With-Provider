import 'package:apiwithprovider/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  void handShakeNotifier(){

     var usermodel = Provider.of<UserProvider>(context,listen:  false);
     var list = usermodel.users;
     print(list.length);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Using Provider"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: SizedBox(
            height: 200,
            child: userListItemWidget(),
          )),
          Text("Host Reload",
            style: TextStyle(
              backgroundColor: Colors.green,
              fontSize: 40
            ),
          )
        ],
      )
    );

  }

  Widget userListItemWidget(){
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Builder(builder: (context){
        final model = Provider.of<UserProvider>(context);

        if (model.responseState == ResponseState.LOADING) {
          return Center(child: CircularProgressIndicator());
        }
        if (model.responseState == ResponseState.ERROR) {
          return Center(child: Text('An Error Occurred ${model.message}'));
        }
        final users = model.users;

        return ListView.builder(
          itemCount: users.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              child: ListTile(
                title: Text(user.name),
                subtitle: Text(user.address.street),
              ),
            );
          },
        );



      },
      ),

    );
  }
}
