class Capitulo {
  late final String imagePath;
  late final String capitulo;
  late final String tema;
  late final String descripcion;
  late final String minutos;
  late final String gd;
  late final String color;
  late final String txtcolor;

  Capitulo({
    required this.imagePath,
    required this.capitulo,
    required this.tema,
    required this.descripcion,
    required this.minutos,
    required this.gd,
    required this.color,
    required this.txtcolor,

  });
}

List<Capitulo> temas = [

    Capitulo(
    imagePath: 'assets/images/icons/tejido_1.png', 
    capitulo: '1', 
    tema: 'Histología', 
    descripcion: 'Nos permite el estudio de las células integradas en tejidos, órganos y sistemas del cuerpo humano sin enfermedad para luego aprender sobre las diferentes enfermedades, esta es la base de las medidas terapéuticas que aplica la medicina.', 
    minutos: '15 min.',
    gd: '10%', 
    color: 'FF895476',
    txtcolor: 'FFF2F0E0',
    ),

  Capitulo(
    imagePath: 'assets/images/icons/microscopio.png', 
    capitulo: '1', 
    tema: 'Microscopía', 
    descripcion: 'Comprender los tipos y usos de los microscopios, sus componentes y aplicaciones en histología, incluyendo la microscopía virtual para analizar muestras digitalizadas.', 
    minutos: '15 min.',
    gd: '30%', 
    color: 'fee8d9ca',
    txtcolor: 'FF895476',

  ),

    Capitulo(
    imagePath: 'assets/images/icons/niveles.png', 
    capitulo: '1', 
    tema: 'Niveles de Organización', 
    descripcion: 'Comprender la microanatomía de las células\n, tejidos y órganos, correlacionando la estructura con la función, desde la célula eucariota hasta los sistemas de órganos.',
    minutos: '15 min.',
    gd: '30%',
      color: 'FF895476',
      txtcolor: 'FFF2F0E0',
    ),



];
