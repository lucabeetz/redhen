// swiftlint:disable all
import Amplify
import Foundation

public struct Restaurant: Model {
  public let id: String
  public var name: String
  public var menu: [String]?
  public var location: Location
  public var telephone: String?
  public var website: String?
  public var type: RestaurantType
  public var ar: Bool
  public var review: Double?
  public var hours: [Temporal.Time]?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      menu: [String]? = nil,
      location: Location,
      telephone: String? = nil,
      website: String? = nil,
      type: RestaurantType,
      ar: Bool,
      review: Double? = nil,
      hours: [Temporal.Time]? = nil) {
    self.init(id: id,
      name: name,
      menu: menu,
      location: location,
      telephone: telephone,
      website: website,
      type: type,
      ar: ar,
      review: review,
      hours: hours,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      menu: [String]? = nil,
      location: Location,
      telephone: String? = nil,
      website: String? = nil,
      type: RestaurantType,
      ar: Bool,
      review: Double? = nil,
      hours: [Temporal.Time]? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.menu = menu
      self.location = location
      self.telephone = telephone
      self.website = website
      self.type = type
      self.ar = ar
      self.review = review
      self.hours = hours
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}