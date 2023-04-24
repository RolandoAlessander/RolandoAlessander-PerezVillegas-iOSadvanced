//
//  assessment_iosApp.swift
//  assessment-ios
//
//  Created by Ivan Trejo on 15/04/23.
//

import SwiftUI

@main
struct assessment_iosApp: App {

    var body: some Scene {
        WindowGroup {
          PokedexHomeRouter.createPokedexHomeView()
        }
    }
}
