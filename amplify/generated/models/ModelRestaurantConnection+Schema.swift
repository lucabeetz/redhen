// swiftlint:disable all
import Amplify
import Foundation

extension ModelRestaurantConnection {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case items
    case total
    case nextToken
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let modelRestaurantConnection = ModelRestaurantConnection.keys
    
    model.syncPluralName = "ModelRestaurantConnections"
    
    model.fields(
      .field(modelRestaurantConnection.items, is: .optional, ofType: .collection(of: Restaurant.self)),
      .field(modelRestaurantConnection.total, is: .optional, ofType: .int),
      .field(modelRestaurantConnection.nextToken, is: .optional, ofType: .string)
    )
    }
}
