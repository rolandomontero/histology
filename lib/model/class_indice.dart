class Capitulo {
  late final String imagePath;
  late final String capitulo;
  late final String tema;
  late final String descripcion;
  late final String minutos;
  late final String gd;
  late final String color;

  Capitulo({
    required this.imagePath,
    required this.capitulo,
    required this.tema,
    required this.descripcion,
    required this.minutos,
    required this.gd,
    required this.color,
  });
}

List<Capitulo> temas = [

    Capitulo(
    imagePath: 'assets/images/icons/tejido_1.png', 
    capitulo: '1', 
    tema: 'Histología', 
    descripcion: 'Nos permite el estudio de las células integradas en tejidos, órganos y sistemas del cuerpo humano sin enfermedad para luego aprender sobre las diferentes enfermedades, esta es la base de las medidas terapéuticas que aplica la medicina.', 
    minutos: '15', 
    gd: '10%', 
    color: 'FF895476'),

  Capitulo(
    imagePath: 'assets/images/icons/microscopio.png', 
    capitulo: '1', 
    tema: 'Microscopía', 
    descripcion: 'Comprender los tipos y usos de los microscopios, sus componentes y aplicaciones en histología, incluyendo la microscopía virtual para analizar muestras digitalizadas.', 
    minutos: '15', 
    gd: '30%', 
    color: 'fee8d9ca'),

    Capitulo(
    imagePath: 'assets/images/icons/niveles.png', 
    capitulo: '1', 
    tema: 'Niveles de Organización', 
    descripcion: 'Comprender la microanatomía de las células, tejidos y órganos, correlacionando la estructura con la función, desde la célula eucariota hasta los sistemas de órganos.', 
    minutos: '15', 
    gd: '30%', 
    color: 'FF895476'),



];

      // -----------------------------------------------------------------+
      // 'imagePath': 'assets/images/icons/tejido_2.png',
      // 'tema': 'Microscopía',
      // 'descripción':
      //     'Comprender los tipos y usos de los microscopios, sus componentes y aplicaciones en histología, incluyendo la microscopía virtual para analizar muestras digitalizadas.',
      // 'horas': '10',
      // 'puntos': '30',
      // 'color': '0xDCE8D9C7'
      // -----------------------------------------------------------------+

List<Map<String, String>> capitulos = [
  {
    'Capitulo':'1',
    'imagePath':'',
    'Nombre':'INTRODUCCIÓN A LA HISTOLOGIA y MÉTODOS DE ESTUDIO',
    'Descripcion':'',
    'Color':'FFFFFFFF'
  },
    {
    'Capitulo':'2',
    'imagePath':'',
    'Nombre':'TEJIDO EPITELIAL: REVESTIMIENTO y GLANDULARES',
    'Descripcion':'',
    'Color':'FFFFFFFF'
  },
    {
    'Capitulo':'3',
    'imagePath':'',
    'Nombre':'TEJIDO CONECTIVO I',
    'Descripcion':'',
    'Color':'FFFFFFFF'
  },
    {
    'Capitulo':'1',
    'imagePath':'',
    'Nombre':'INTRODUCCIÓN A LA HISTOLOGIA y MÉTODOS DE ESTUDIO',
    'Descripcion':'',
    'Color':'FFFFFFFF'
  },
    {
    'Capitulo':'1',
    'Nombre':'INTRODUCCIÓN A LA HISTOLOGIA y MÉTODOS DE ESTUDIO',
    'Descripcion':'',
    'Color':'FFFFFFFF'
  },
  
  
  
  
  
  
  
  
  
  ];  