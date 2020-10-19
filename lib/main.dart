import 'package:flutter/material.dart';
import 'package:crud_with_flutter/models/contact.dart';

void main() {
  runApp(MyApp());
}

const darkBlueColor = Color(0xff486579);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),

      home: MyHomePage(),


    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Contact _contact = Contact(); //we have instantiated the class Contact of user-defined data type Contact
  List<Contact> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: Center(
          child: Text(
            "Contact List",
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget> [
            _form(),
            _list(),
          ],
        ),
      ),
    );
  }

  //Form is an important element in any application to accept user inputs in any application. Now to design a form let’s update the _form() as follows.
  final _formKey = GlobalKey<FormState>();

  _form() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children:<Widget> [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (val) => (val.length == 0? 'This Field is mandatory' : null),
              onSaved: (val) => setState(
                  () => _contact.name = val
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile No.'),
              validator: (val) => (val.length == 0? 'This field is also mandatory' : null),
              onSaved: (val) => setState(
                  () => _contact.mobile = val
              ),
            ),

            RaisedButton(
              onPressed: (){
                _onSubmit();
              },
              child: Text('SUBMIT'),
              color: darkBlueColor,
              textColor: Colors.white,
            )

          ],
        ),
      ),
    );

  _onSubmit() async{

    var form = _formKey.currentState;
    if(form.validate()){
      form.save();
      print('''
      Full Name: ${_contact.name}
      Mobile:${_contact.mobile}
      ''');
      
      _contacts.add(Contact(id:null,name: _contact.name, mobile: _contact.mobile));
      form.reset();
    }
  }
//Now let’s update _list() function, so that we can iterate though _contacts list with the help of ListView widget.

  _list() => Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.all(5),
            //itemBuilder iterates through the context, displaying all 'i' data items 'itemCount' times
            itemBuilder: (context, i){
              return Column(
                children:<Widget> [
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: darkBlueColor,
                      size: 40,
                    ),
                    title: Text(
                      _contacts[i].name.toUpperCase(),
                      style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_contacts[i].mobile),
                    onTap: (){},
                  ),
                  Divider(
                    height: 5.0,
                  )
                ],
              );
            },

            itemCount: _contacts.length,

        ),
      ),
    ),
  );
}


