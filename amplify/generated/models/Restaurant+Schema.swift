// swiftlint:disable all
import Amplify
import Foundation

extension Restaurant {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case menu
    case location
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let restaurant = Restaurant.keys
    
    model.pluralName = "Restaurants"
    
    model.fields(
      .id(),
      .field(restaurant.name, is: .required, ofType: .string),
      .field(restaurant.menu, is: .optional, ofType: .string),
      .field(restaurant.location, is: .required, ofType: .embedded(type: Location.self)),
      .field(restaurant.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(restaurant.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}