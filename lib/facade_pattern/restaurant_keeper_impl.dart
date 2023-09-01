import 'package:clean_architecture_number/facade_pattern/both_restaurant.dart';
import 'package:clean_architecture_number/facade_pattern/non_veg_restaurant.dart';
import 'package:clean_architecture_number/facade_pattern/restaurant_keeper.dart';
import 'package:clean_architecture_number/facade_pattern/veg_restaurant.dart';

class RestaurantKeeperImpl extends RestaurantKeeper{
  @override
  String getBothRestaurant() {
    VegRestaurant v = VegRestaurant();
    return v.getMenus();
  }

  @override
  String getNonVegRestaurant() {
    NonVegRestaurant nv = NonVegRestaurant();
    return nv.getMenus();
  }

  @override
  String getVegRestaurant() {
    BothRestaurant br = BothRestaurant();
    return br.getMenus();

  }

}