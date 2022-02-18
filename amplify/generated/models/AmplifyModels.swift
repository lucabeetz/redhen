// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "c47ed72ab7ff731d965f83d2bcb6e550"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Restaurant.self)
  }
}