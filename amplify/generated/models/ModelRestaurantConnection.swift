// swiftlint:disable all
import Amplify
import Foundation

public struct ModelRestaurantConnection: Embeddable {
  var items: [Restaurant?]?
  var total: Int?
  var nextToken: String?
}