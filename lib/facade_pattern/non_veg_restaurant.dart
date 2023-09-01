import 'package:clean_architecture_number/facade_pattern/restaurant.dart';

class NonVegRestaurant extends Restaurant{
  @override
  getMenus() {
    var nonV="nonVegatable";
    return nonV;
  }

}