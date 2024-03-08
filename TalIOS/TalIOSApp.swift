//
//  TalIOSApp.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/6/24.
//

import SwiftUI

@main
struct TalIOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

