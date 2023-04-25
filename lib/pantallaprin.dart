import 'package:flutter/material.dart';
import 'conexion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

final User? user = FirebaseAuth.instance.currentUser;

class HomePage extends StatefulWidget {
  String email;
  HomePage({Key? key, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Pacientes');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Algo salió mal");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("El documento no existe");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Inicio'),
                  bottom: const TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Datos del paciente',
                        icon: Icon(Icons.assignment_ind),
                      ),
                      Tab(
                        text: 'Receta',
                        icon: Icon(Icons.image),
                      ),
                      Tab(
                        text: 'Datos medicos',
                        icon: Icon(Icons.assignment),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Bienvenido:",
                              style: TextStyle(
                                fontSize: 40.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAXHBQYjWqDpk2QZyIZCs5aExLskBCX_al2Q&usqp=CAU",
                                height: 200,
                              ),
                            ],
                          )),
                          Center(
                            child: Text(
                              "Nombre(s): ${data['firstName']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Apellido(s): ${data['lastName']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Crup: ${data['curp']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Nacionalidad: ${data['nacionalidad']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Domicilio: ${data['domicilio']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Receta medica:",
                              style: TextStyle(
                                fontSize: 40.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "${data['imgUser']}",
                                //Image.network("${data['imgUser']}"),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ), 
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Registro medico:",
                              style: TextStyle(
                                fontSize: 40.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://imgs.search.brave.com/AZoR1gEclGU2n3jUMBZ_YLOVY5FEuwTcMtZaEoqm5Xs/rs:fit:1024:1024:1/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vdmVjdG9y/cy9tZWRpY2FsLXJl/Y29yZC1pY29uLW1l/ZGljYWwtcmVwb3J0/LWljb24taGVhbHRo/LWNhcmUtZGlhZ25v/c2lzLWljb24tdmVj/dG9yLWlkMTQwOTQ1/MzQ4Mg",
                                height: 200,
                              ),
                            ],
                          )),
                          Center(
                            child: Text(
                              "Enfermedad: ${data['enfermedad']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Alergia: ${data['alergia']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Nombre del medico: ${data['medico']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Tratamiento: ${data['tratamiento']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Medicamento recetado: ${data['medicamento']}",
                              style: TextStyle(
                                fontSize: 20.0, // Tamaño de fuente
                                color: Colors.black, // Color de fuente
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Text("Cargando datos...");
        });
  }
}

 /** Aplicar funciones
 * 
 * body: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        'Bienvenido Usuario:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data['imgUser']),
                    ),
                    Center(
                      child: Text(
                        "Nombre(s): ${data['firstName']}",
                        style: TextStyle(
                          fontSize: 20.0, // Tamaño de fuente
                          color: Colors.black, // Color de fuente
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Apellido(s): ${data['lastName']}",
                        style: TextStyle(
                          fontSize: 20.0, // Tamaño de fuente
                          color: Colors.black, // Color de fuente
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Correo Electrónico: ${widget.email}",
                        style: TextStyle(
                          fontSize: 10.0, // Tamaño de fuente
                          color: Colors.black, // Color de fuente
                        ),
                      ),
                    ),
                    /* Center(
                      child:user==null? Text("cargando datos"):Text("Correo Electrónico: ${user!.email}"),
                    ), */
                  ],
                ),
                /* TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConexionFirebase()),
                    );
                  },
                  child: Text('Regresar al inicio de sesion'),
                ), */
              ],
            ),
 */
