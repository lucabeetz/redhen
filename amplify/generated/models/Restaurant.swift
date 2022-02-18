// swiftlint:disable all
import Amplify
import Foundation

public struct Restaurant: Model {
  public let id: String
  public var name: String
  public var menu: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      menu: String? = nil) {
    self.init(id: id,
      name: name,
      menu: menu,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      menu: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.menu = menu
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}