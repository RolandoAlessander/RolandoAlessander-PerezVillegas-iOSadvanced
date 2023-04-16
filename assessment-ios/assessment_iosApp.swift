//
//  assessment_iosApp.swift
//  assessment-ios
//
//  Created by Ivan Trejo on 15/04/23.
//

import SwiftUI

@main
struct assessment_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
