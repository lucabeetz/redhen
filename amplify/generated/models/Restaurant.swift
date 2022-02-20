// swiftlint:disable all
import Amplify
import Foundation

public struct Restaurant: Model {
  public let id: String
  public var name: String
  public var menu: String?
  public var location: Location
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      menu: String? = nil,
      location: Location) {
    self.init(id: id,
      name: name,
      menu: menu,
      location: location,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      menu: String? = nil,
      location: Location,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.menu = menu
      self.location = location
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}