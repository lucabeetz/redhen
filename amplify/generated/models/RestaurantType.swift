// swiftlint:disable all
import Amplify
import Foundation

public enum RestaurantType: String, EnumPersistable {
  case restaurant = "Restaurant"
  case cocktail = "Cocktail"
  case cafe = "Cafe"
  case toGo = "ToGo"
}