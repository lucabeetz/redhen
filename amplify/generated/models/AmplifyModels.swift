// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "157502619a44c367f7b5179eb1788ecf"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Restaurant.self)
  }
}