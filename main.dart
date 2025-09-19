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
  int currentPageIndex = 0;
  final TextEditingController _nombreControlador = TextEditingController();
  final TextEditingController _emailControlador = TextEditingController();

  bool _aceptarTerminos = false;
  bool _notificaciones = true;

  double _edad = 20;
  String _seleccionarPais = 'Perú';
  String _genero = 'Masculino';

  // Variables para manejar errores de validación
  String? _nombreError;
  String? _emailError;
  String? _terminosError;

 final List<String> _paises = ['Perú', 'Chile', 'Argentina', 'Colombia', 'Brasil'];
 static const List<(Color?, Color? background, ShapeBorder?)> _customizations =
      <(Color?, Color?, ShapeBorder?)>[
        (null, null, null), // The FAB uses its default for null parameters.
        (null, Colors.green, null),
        (Colors.white, Colors.green, null),
        (Colors.white, Colors.green, CircleBorder()),
      ]; // Selects the customization.
 int _fabIndex = 0;

 // Funciones de validación
 String? _validarNombre(String? valor) {
   if (valor == null || valor.trim().isEmpty) {
     return 'El nombre es obligatorio';
   }
   if (valor.trim().length < 2) {
     return 'El nombre debe tener al menos 2 caracteres';
   }
   if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(valor)) {
     return 'El nombre solo puede contener letras y espacios';
   }
   return null;
 }

 String? _validarEmail(String? valor) {
   if (valor == null || valor.trim().isEmpty) {
     return 'El email es obligatorio';
   }
   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valor)) {
     return 'Ingrese un email válido';
   }
   return null;
 }

 String? _validarTerminos() {
   if (!_aceptarTerminos) {
     return 'Debe aceptar los términos y condiciones';
   }
   return null;
 }

 bool _validarFormulario() {
   setState(() {
     _nombreError = _validarNombre(_nombreControlador.text);
     _emailError = _validarEmail(_emailControlador.text);
     _terminosError = _validarTerminos();
   });
   
   return _nombreError == null && _emailError == null && _terminosError == null;
 }
 void _mostrarDatosFormulario(){
   // Validar formulario antes de mostrar datos
   if (!_validarFormulario()) {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
         content: Text('Por favor, corrija los errores en el formulario'),
         backgroundColor: Colors.red,
       ),
     );
     return;
   }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Datos del Formulario'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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

 void _limpiarFormulario() {
    setState(() {
      _nombreControlador.clear();
      _emailControlador.clear();
      _edad = 20;
      _seleccionarPais = 'Perú';
      _genero = 'Masculino';
      _aceptarTerminos = false;
      _notificaciones = true;
      // Limpiar errores de validación
      _nombreError = null;
      _emailError = null;
      _terminosError = null;
    });
  }
  @override
  Widget build(BuildContext context) {
   final ThemeData theme = Theme.of(context);
    return Scaffold(
       bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
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
              onChanged: (value) {
                setState(() {
                  _nombreError = _validarNombre(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Nombres completos',
                hintText: 'Ingrese sus nombres completos',
                border: const OutlineInputBorder(),
                errorText: _nombreError,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailControlador,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _emailError = _validarEmail(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                hintText: 'ejemplo@correo.com',
                border: const OutlineInputBorder(),
                errorText: _emailError,
                prefixIcon: const Icon(Icons.email),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text('Aceptar Términos y Condiciones'),
                  value: _aceptarTerminos,
                  onChanged: (bool? value) {
                    setState(() {
                      _aceptarTerminos = value!;
                      _terminosError = _validarTerminos();
                    });
                  },
                ),
                if (_terminosError != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      _terminosError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
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
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _mostrarDatosFormulario,
                  child: const Text('Mostrar Datos'),
                ),
                 ElevatedButton(
                  onPressed: _limpiarFormulario,
                  child: const Text('Limpiar Formulario'),
                ),
              ]
            )
          ]
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
             _fabIndex = (_fabIndex + 1) % _customizations.length;
          });
        },
        foregroundColor: _customizations[_fabIndex].$1,
        backgroundColor:_customizations[_fabIndex].$2,
        shape: _customizations[_fabIndex].$3,
        child: const Icon(Icons.navigation),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


