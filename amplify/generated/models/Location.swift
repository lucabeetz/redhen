// swiftlint:disable all
import Amplify
import Foundation

public struct Location: Embeddable {
  var lat: Double
  var lon: Double
  var street: String?
  var number: Int?
  var postalCode: Int?
  var city: String?
  var country: String?
}