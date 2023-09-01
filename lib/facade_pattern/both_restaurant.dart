import 'package:clean_architecture_number/facade_pattern/restaurant.dart';

class BothRestaurant extends Restaurant{
  @override
  getMenus() {
    var bothR = "bothType";
    return bothR;
  }

}