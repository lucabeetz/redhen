//
//  MenewApp.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import Amplify
import AWSDataStorePlugin
import AWSAPIPlugin

@main
struct MenewApp: App {
    var body: some Scene {
        WindowGroup {
                ContentView()
            
        }
    }
    
    func configureAmplify() {
        let models = AmplifyModels()
        let apiPlugin = AWSAPIPlugin(modelRegistration: models)
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: apiPlugin)
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify")
        } catch {
            assert(false, "Could not initialize Amplify: \(error)")
        }
    }
    
    init() {
        configureAmplify()
    }
}
