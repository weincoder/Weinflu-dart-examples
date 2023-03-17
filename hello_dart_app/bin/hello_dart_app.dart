import 'package:hello_dart_app/hello_dart_app.dart' as hello_dart_app;

void main() {
  //puedo colocar comentarios sobre mi código
  //esto no afectará la ejecución de mi software
  var apodo = 'Weincoders';
  var saludo = 'Hola $apodo';
  double estatura = 1.67;
  bool esFalso = false;
  List<int> edades = [20, 23, 45, 67, 12, 14, 19, 34, 23, 23];
  print(saludo);
  print(esFalso);
  print(estatura);
  print(edades);

  //Existe un tiempo para todo
  //Las variables constantes
  const estoNoCambia = 'Weinflu';
  //Esto falla porque las constantes deben ser arignadas antes de tiempo de ejecución
  final estoSeAsignaEnEjecucion = funcionNoDevuelveNada();

  print(estoSeAsignaEnEjecucion);
  // Dart es un lenguaje que te proteje de valores nulos por ejemplo
  int edad = 29;
  late final String nombreEstudiante;
  nombreEstudiante = getStudentName();
  print(nombreEstudiante);
  print(edad + 4);

  //Sin embargo en ciertas ocasiones podremos tener valores que probablemente sean vacios
  // String? comidaFavorita;

  // print('comida favorita es : $comidaFavorita');
  // var esperoNoSerNulo = '${comidaFavorita!} some';

  // print(esperoNoSerNulo);
  print(deprontoNoDevuelvoNada(18));
  print(deprontoNoDevuelvoNada(20));
  //por eso debemos tener mucho cuidado por que podemos terminar operando con valores nulos
  // dadonos cuenta unicamente en la aplicación final.

  //repasemos algunos elementos de sintaxis en dart
  for (var i = 0; i < 19; i++) {
    print('Estamos en la iteracion $i');
  }
  int contador = 0;
  String todoAndaBien = 'todo super bien';
  while (todoAndaBien == 'todo super bien') {
    print('vamos por otra repetición');
    contador++;
    if (contador > 5) {
      print('Ahora todo anda exageradamente bien');
      todoAndaBien = 'todo anda exageradamente bien';
    }
  }

  //Tambien tenemos operadores ternarios
  bool todoContoBien = contador > 5 ? true : false;
  print(todoContoBien);

  //Por otro lado en dart no Existe las interfaces sino clases abstractas
  var nuevoIngeniero = Ingeniero(
      name: 'Weincoder',
      edad: 1000,
      estatura: estatura,
      profesion: 'Ingeniero de Software',
      software: 'Dart');

  nuevoIngeniero.saludar();
  nuevoIngeniero.programar();

  //En Dart existe un tema muy interesante y son los futuros y los Streams
  //Podemos entender los futuros como un valor que se lo podremos obtener en un futuro,
  // Es similar a las promesas en  JavaScript
  mostrarMensajeDelFuturo();
}

Future<void> mostrarMensajeDelFuturo() async {
  // enUnFuturoCercano().then((value) => print(value));
  // enUnFuturoAunMasCercano().then((value) => print(value));
  enUnFuturoCercano().then(
    (mensajeDeUnFuturoLejano) {
      medirMensajeDelFuturo(mensajeDeUnFuturoLejano)
          .then((value) => print('El tamaño del mensaje es $value'));
    },
  );
  //Esto comienza a verse enredado, no creen?
  // enUnFuturoCercano().then(
  //   (mensajeDeUnFuturoLejano) {
  //     medirMensajeDelFuturo(mensajeDeUnFuturoLejano).then(
  //       (value) {
  //         print(value);
  //         enUnFuturoAunMasCercano().then(
  //           (mensajeDeUnFuturoCercano) {
  //             medirMensajeDelFuturo(mensajeDeUnFuturoCercano)
  //                 .then((segundoMensaje) => print(segundoMensaje));
  //           },
  //         );
  //       },
  //     );
  //   },
  // );

  //esto es mucho más claro!!!!
  String primerMensaje = await enUnFuturoCercano();
  String mensajePrimerConteo = await medirMensajeDelFuturo(primerMensaje);
  print(mensajePrimerConteo);
  String segundoMensaje = await enUnFuturoAunMasCercano();
  String mensajeSegundoConteo = await medirMensajeDelFuturo(segundoMensaje);
  print(mensajeSegundoConteo);


  print('por ahora no ha llegado el mensaje');
  print('se demora un poco en llegar el mensaje del futuro');
  //podemos escuchar cada uno de los retornos de un stream de forma que podamos ejecutar una acción ante
  //un valor nuevo
  countDown(10, 0).listen((event) {
    print(event);
  });
  print('sin embargo esto no boloquea el código 🥸');
  showNames().listen((nombre) {
    print(nombre);
  });
  //esto es muy poderozo por ende debemos utilizar de forma correcta los futuros y los streams
  // pues harán a nuestras aplicaciones no bloqueantes


  //Veamos unos puntos adicionales

  //al igual que en otros lenguajes tenemos las funciones anónimas, de hecho ya las hemos usado 
  //durante el video
  const listOfNames = ['weincoder', 'dash', 'mafer'];
  listOfNames.map((name) {
    return name.toUpperCase();
  }).forEach((name) {
    print('$name: ${name.length}');
  });

  
}


// En flutter también existen los streams, que los podemos ver como un flujo de datos

//por ejemplo que tal el siguiente reto mostrar en pantalla dos numeros y un nombre pro segundo
Stream<int> countDown(int start, int end) async* {
  //esta función devolverá un flujo de datos dependiendo de unos datos de inicio y final
  for (var i = start; i >= end; i--) {
    await Future.delayed(Duration(milliseconds: 500));
    //el yield indica que devolvera por iteración
    yield i;
  }
}
//hacemos lo mismos para los nombres
Stream<String> showNames() async* {
  List nombres = ['Daniel', 'Mafer', 'Esteban', 'Ana', 'Pepito'];

  for (String name in nombres) {
    await Future.delayed(Duration(seconds: 1));
    yield name;
  }
}

Future<String> medirMensajeDelFuturo(String mensaje) async {
  await Future.delayed(Duration(milliseconds: 2000));
  print('perdonen que me demoro mucho contando');
  return Future.value(
      'el mensaje del futuro mide lo siguiente ${mensaje.length}');
}

Future<String> enUnFuturoCercano() async {
  await Future.delayed(Duration(milliseconds: 500));

  return Future.value('Todo terminó de forma exitosa');
}

Future<String> enUnFuturoAunMasCercano() async {
  await Future.delayed(Duration(milliseconds: 200));

  return Future.value('Todo terminó de forma exitosa en el futuro cercano 🤯');
}

abstract class Humano {
  final String name;
  final int edad;
  final double estatura;

  Humano({required this.name, required this.edad, required this.estatura});

  void saludar() {
    print('hola mi nombre es $name espero que seas muy atento en tu curso');
  }
}

abstract class Programador {
  final String software;

  Programador(this.software);

  void programar() {}
}

class Ingeniero extends Humano implements Programador {
  final String profesion;
  @override
  final String software;
  Ingeniero(
      {required super.name,
      required super.edad,
      required super.estatura,
      required this.profesion,
      required this.software});

  @override
  void programar() {
    print('hola soy $name y voy a programar en $software');
  }
}

//las funciones tambien pueden ser condicionalmente nulas

String? deprontoNoDevuelvoNada(int edad) {
  if (edad > 18) {
    return 'puede entrar';
  } else {
    return null;
  }
}

String funcionNoDevuelveNada() {
  return 'nada';
}

String getStudentName() {
  return 'No es nulo';
}
