import 'package:legalis/model/resource.dart';
import 'package:legalis/utils/base_model.dart';

class HelpViewModel extends BaseModel {
  final List<dynamic> _testData = [
    {
      'title': 'Busca por palabras claves o experiencias',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    },
    {
      'title': 'Navega por listado de palabras claves',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    },
    {
      'title': 'Explora el directorio temático',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    }
  ];

  Resource<List> _items = Resource.complete([]);

  Resource<List> get items => _items;

  setItems(items) {
    _items = items;
    notifyListeners();
  }

  fetchItems() async {
    setLoading(true);
    final res = await Future.delayed(
        const Duration(milliseconds: 1000), () => _testData);
    setItems(Resource.complete(res));
    setLoading(false);
  }
}
