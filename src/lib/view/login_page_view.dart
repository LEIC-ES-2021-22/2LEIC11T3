import 'package:food_feup/controller/local_storage/app_user_database.dart';

import 'package:flutter/material.dart';
import 'package:food_feup/view/main_page_view.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  static final TextEditingController usernameController =
  TextEditingController();

  static final TextEditingController passwordController =
  TextEditingController();

  bool _obscurePasswordInput = true;

  void _toggleObscurePasswordInput() {
    setState(() {
      _obscurePasswordInput = !_obscurePasswordInput;
    });
  }

  Future<bool> _login() async{
    AppUserDatabase userDatabase = AppUserDatabase();

    final user = usernameController.text.trim();
    final pass = passwordController.text.trim();

    bool loginResult = await userDatabase.checkUser(user, pass);
    if (loginResult){
      //TODO: GO TO NEXT VIEW/PAGE
      usernameController.clear();
      passwordController.clear();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),);




      print("sucessful login");
    }else{
      print("unsucessful login");
    }



    return false;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView(
            children: getWidgets(context),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  InputDecoration textFieldDecoration(String placeholder) {
    return InputDecoration(
        hintStyle: const TextStyle(color: Colors.black),
        errorStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: placeholder,
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: UnderlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 3)));
  }

  InputDecoration passwordFieldDecoration(String placeholder) {
    final genericDecoration = textFieldDecoration(placeholder);
    return InputDecoration(
        hintStyle: genericDecoration.hintStyle,
        errorStyle: genericDecoration.errorStyle,
        hintText: genericDecoration.hintText,
        contentPadding: genericDecoration.contentPadding,
        border: genericDecoration.border,
        focusedBorder: genericDecoration.focusedBorder,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePasswordInput ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleObscurePasswordInput,
          color: Colors.red,
        ));
  }

  Widget createPasswordInput() {
    return TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 20),
        enableSuggestions: false,
        autocorrect: false,
        autofocus: false,
        controller: passwordController,
        //focusNode: passwordFocus,
        /*
        onFieldSubmitted: (term) {
          passwordFocus.unfocus();
          _login(context);
        },*/
        textInputAction: TextInputAction.done,
        obscureText: _obscurePasswordInput,
        enableInteractiveSelection: !_obscurePasswordInput,
        textAlign: TextAlign.left,
        decoration: passwordFieldDecoration('palavra-passe'),

        //validator: (String value) =>
        //value.isEmpty ? 'Preenche este campo' : null);
    );
  }

  Widget createUsernameInput(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: 20),
      enableSuggestions: false,
      autocorrect: false,
      autofocus: false,
      controller: usernameController,
      //focusNode: usernameFocus,
      /*
      onFieldSubmitted: (term) {
        usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(passwordFocus);
      },*/
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.left,
      decoration: textFieldDecoration('número de estudante'),
      //validator: (String value) => value.isEmpty ? 'Preenche este campo' : null,
    );
  }
  
  Widget createLogInButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        height: 50,
        width: 250,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            primary: Colors.red,
          ),
          onPressed: _login,
          /*
          onPressed: () {
            if (!FocusScope.of(context).hasPrimaryFocus) {
              FocusScope.of(context).unfocus();
            }
            _login(context);
          },*/
          child: Text('LogIn',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget createLogo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('Images/logo.png'),
        ),
      ),
    );
  }

  List<Widget> getWidgets(BuildContext context) {
    final List<Widget> widgets = [];

    widgets.add(createLogo(context));
    widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)));
    widgets.add(createUsernameInput(context));
    widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)));
    widgets.add(createPasswordInput());
    
    widgets.add(createLogInButton(context));

    return widgets;
  }

}