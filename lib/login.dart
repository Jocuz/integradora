import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pantallaprin.dart';
import 'signup.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? mensajeError = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text('Inicio de sesion'),
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Column(
            children:[
              CircleAvatar(
                radius: 70, // Tamaño del círculo
                backgroundImage: NetworkImage('https://imgs.search.brave.com/3uiFwAtD0XSpeSLFE4XZ8vnK9Nneow8gdAzGGNL99ck/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvcHJl/dmlld3MvMDAwLzU3/NC81MTIvb3JpZ2lu/YWwvdmVjdG9yLXNp/Z24tb2YtdXNlci1p/Y29uLmpwZw'),
                )]
                
          ),
          Center(
            child: Text(
              mensajeError!,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo:',
            ),
          ),
          SizedBox(
                height: 40,
              ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña:',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(50, 10)), // Cambia el tamaño fijo
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)), // Ajusta el padding
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Cambia el color de fondo
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                 ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Iniciar sesion"), Icon(Icons.assignment_ind_rounded)],
                  )),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
            child: const Text('¿Nuevo Usuario? crea una cuenta', style: TextStyle(color: Colors.blue,fontSize: 15)),
          ),
        ],
      ),
    );
  }

  void signIn() async {
    print('print en sign in');
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  email: emailController.text,
                )),
      );
    } on FirebaseAuthException catch (e) {
      print("error");
      print(e.message);
      setState(() {
        mensajeError = e.message;
      });
    }
  }
}
 