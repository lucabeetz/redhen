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
    case telephone
    case website
    case type
    case ar
    case review
    case hours
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let restaurant = Restaurant.keys
    
    model.syncPluralName = "Restaurants"
    
    model.fields(
      .id(),
      .field(restaurant.name, is: .required, ofType: .string),
      .field(restaurant.menu, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(restaurant.location, is: .required, ofType: .embedded(type: Location.self)),
      .field(restaurant.telephone, is: .optional, ofType: .string),
      .field(restaurant.website, is: .optional, ofType: .string),
      .field(restaurant.type, is: .required, ofType: .enum(type: RestaurantType.self)),
      .field(restaurant.ar, is: .required, ofType: .bool),
      .field(restaurant.review, is: .optional, ofType: .double),
      .field(restaurant.hours, is: .optional, ofType: .embeddedCollection(of: Temporal.Time.self)),
      .field(restaurant.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(restaurant.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}
