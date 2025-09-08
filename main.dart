import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Clientes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'FORMULARIO DE REGISTRO DE CLIENTES'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _nombreControlador = TextEditingController();

  
  final TextEditingController _emailControlador = TextEditingController();

  bool _aceptarTerminos = false;
  bool _notificaciones = true;

  double _edad = 20;
  String _seleccionarPais = 'Perú';
  String _genero = 'Masculino';

 final List<String> _paises = ['Perú', 'Chile', 'Argentina', 'Colombia', 'Brasil'];

 void _mostrarDatosFormulario(){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Datos del Formulario'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${_nombreControlador.text}'),
            Text('Email: ${_emailControlador.text}'),
            Text('Edad: ${_edad.round()} años'),
            Text('País: $_seleccionarPais'),
            Text('Género: $_genero'),
            Text('Aceptar Términos: ${_aceptarTerminos ? "Sí" : "No"}'),
            Text(
              'Notificaciones: ${_notificaciones ? "Activadas" : "Desactivadas"}'
            ),
          ],
        ),
    
      actions: [
        TextButton(
          onPressed: () =>
            Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
   },
  );
 }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreControlador,
              decoration: const InputDecoration(
                labelText: 'Nombres completos',
                hintText: 'Ingrese sus nombres completos',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailControlador,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                hintText: 'ejemplo@correo.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Edad: ${_edad.round()} años'),
              Slider(
                value: _edad,
                min: 18,
                max: 80,
                divisions: 62,
                label: _edad.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _edad = value;
                  });
                },
              ),
            const SizedBox(height: 16.0),
            const Text('País de Residencia'),
            DropdownButton<String>(
              value: _seleccionarPais,
              isExpanded: true,
              items: _paises.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _seleccionarPais = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Género'),
            RadioListTile<String>(
              title: const Text('Masculino'),
              value: 'Masculino',
              groupValue: _genero,
              onChanged: (String? value) {
                setState(() {
                  _genero = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Femenino'),
              value: 'Femenino',
              groupValue: _genero,
              onChanged: (String? value) {
                setState(() {
                  _genero = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Otro'),
              value: 'Otro',
              groupValue: _genero,
              onChanged: (String? value) {
                setState(() {
                  _genero = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('Aceptar Términos y Condiciones'),
              value: _aceptarTerminos,
              onChanged: (bool? value) {
                setState(() {
                  _aceptarTerminos = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text('Recibir Notificaciones'),
              value: _notificaciones,
              onChanged: (bool value) {
                setState(() {
                  _notificaciones = value;
                });
              },
            ),
          ]
        ),
      )
      ),
      
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
