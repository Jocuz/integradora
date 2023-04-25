import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'conexion.dart';
import 'image.dart';
import 'login.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? mensajeError = "";
  File? imagen_to_upload;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController domicilioController = TextEditingController();
  TextEditingController nacionalidadController = TextEditingController();
  TextEditingController curpController = TextEditingController();
  TextEditingController enfermedadController = TextEditingController();
  TextEditingController alergiaController = TextEditingController();
  TextEditingController tratamientoController = TextEditingController();
  TextEditingController medicamentoController = TextEditingController();
  TextEditingController medicoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Registro'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              "Subir receta",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              mensajeError!,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final imagen = await getImage();
                    setState(() {
                      imagen_to_upload = File(imagen!.path);
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(50, 10)), // Cambia el tamaño fijo
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(5)), // Ajusta el padding
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Cambia el color de fondo
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Cambia el color del texto
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Subir receta"),
                      Icon(Icons.assignment_sharp)
                    ],
                  )),
            ],
          ),
          Container(
            child: (imagen_to_upload != null
                ? Image.file(imagen_to_upload!)
                : SizedBox()),
          ),
          SizedBox(
            height: 10,
          ),
          Center(child:Text('Datos del usuario',style: TextStyle(color: Colors.black, fontSize: 15),),),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
            ),
          ),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: 'Apellidos',
            ),
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo',
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
          TextFormField(
            controller: domicilioController,
            decoration: InputDecoration(
              labelText: 'Domicilio',
            ),
          ),
          TextFormField(
            controller: nacionalidadController,
            decoration: InputDecoration(
              labelText: 'Nacionalidad',
            ),
          ),
          TextFormField(
            controller: curpController,
            decoration: InputDecoration(
              labelText: 'Curp',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(child:Text('Datos medicos del usuario',style: TextStyle(color: Colors.black, fontSize: 15),),),
          TextFormField(
            controller: enfermedadController,
            decoration: InputDecoration(
              labelText: 'Enfermedad',
            ),
          ),
          TextFormField(
            controller: alergiaController,
            decoration: InputDecoration(
              labelText: 'Alergia',
            ),
          ),
          TextFormField(
            controller: medicoController,
            decoration: InputDecoration(
              labelText: 'Nombre del medico',
            ),
          ),
          TextFormField(
            controller: tratamientoController,
            decoration: InputDecoration(
              labelText: 'Tratamiento',
            ),
          ),
          TextFormField(
            controller: medicamentoController,
            decoration: InputDecoration(
              labelText: 'Medicamento',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    if ((firstNameController.text == "") ||
                        (lastNameController.text == "") ||
                        (emailController.text == "") ||
                        (passwordController.text == "") ||
                        //Agregar los demas
                        (domicilioController.text == "") ||
                        (nacionalidadController.text == "") ||
                        (curpController.text == "") ||
                        (enfermedadController.text == "") ||
                        (alergiaController.text == "") ||
                        (medicoController.text == "") ||
                        (tratamientoController.text == "") ||
                        (medicamentoController.text == "") ||
                        (imagen_to_upload == null)) {
                      setState(() {
                        mensajeError = "Favor de llenar los datos completos";
                      });
                    } else {
                      addNewUser();
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(50, 10)), // Cambia el tamaño fijo
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(5)), // Ajusta el padding
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Cambia el color de fondo
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Cambia el color del texto
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Registrar"), Icon(Icons.assignment_add)],
                  )),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConexionFirebase()),
              );
            },
            child: Text(
              'En caso de estar registrado, Inicia sesión',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  void addNewUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      User? user = userCredential.user;

      /* Subir la imagen de perfil a Storage */
      Reference ref =
          FirebaseStorage.instance.ref().child('Recetas/${user!.uid}');
      UploadTask uploadTask = ref.putFile(imagen_to_upload!);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      /* agreggar informacion */
      await FirebaseFirestore.instance
          .collection('Pacientes')
          .doc(emailController.text)
          .set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        //Agregar los demas
        'domicilio': domicilioController.text,
        'nacionalidad': nacionalidadController.text,
        'curp': curpController.text,
        'enfermedad': enfermedadController.text,
        'alergia': alergiaController.text,
        'medico': medicoController.text,
        'tratamiento': tratamientoController.text,
        'medicamento': medicamentoController.text,

        'imgUser': downloadUrl,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {}
  }

  void addImgUser(String email) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Pacientes');
    final Reference ref = FirebaseStorage.instance.ref().child('images/$email');
    String urlImg = await ref.getDownloadURL();

    users.doc(email).set({'imgUser': urlImg}, SetOptions(merge: true));
  }

  void addUserFirestore(
    String firstName,
    String lastName,
    String email,
    String password,
    String domicilio,
    String nacionalidad,
    String curp,
    String enfermedad,
    String alergia,
    String medico,
    String tratamiento,
    String medicamento
  ) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Pacientes');

    users.doc(email).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'domicilio': domicilio,
      'nacionalidad': nacionalidad,
      'curp': curp,
      'enfermedad': enfermedad,
      'alergia': alergia,
      'medico': medico,
      'tratamiento': tratamiento,
      'medicamento': medicamento,
    });
  }

  signUp() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(() {
        mensajeError = e.message;
      });
    }
  }
}


  /* 

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
*/