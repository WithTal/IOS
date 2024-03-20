//
//  TalIOSApp.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/6/24.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity


@main
struct TalIOSApp: App {
    
    
    let persistenceController = PersistenceController.shared
    let center = AuthorizationCenter.shared
    @StateObject var model = MyModel.shared
    @StateObject var store = ManagedSettingsStore()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(store)
            
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to enroll with error: \(error)")
                        }
                    }
                }

        }
    }
}
