// swiftlint:disable all
import Amplify
import Foundation

extension Location {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case lat
    case lon
    case street
    case number
    case postalCode
    case city
    case country
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let location = Location.keys
    
    model.pluralName = "Locations"
    
    model.fields(
      .field(location.lat, is: .required, ofType: .double),
      .field(location.lon, is: .required, ofType: .double),
      .field(location.street, is: .optional, ofType: .string),
      .field(location.number, is: .optional, ofType: .int),
      .field(location.postalCode, is: .optional, ofType: .int),
      .field(location.city, is: .optional, ofType: .string),
      .field(location.country, is: .optional, ofType: .string)
    )
    }
}