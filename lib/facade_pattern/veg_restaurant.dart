import 'package:clean_architecture_number/facade_pattern/restaurant.dart';

class VegRestaurant extends Restaurant{
  @override
  String getMenus() {
    var v = "vegetable";
    return v;
  }

}