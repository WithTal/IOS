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

import FirebaseCore
import Firebase


import UIKit
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}


//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}




@main
struct TalIOSApp: App {

    
    let persistenceController = PersistenceController.shared
    let center = AuthorizationCenter.shared
//    @StateObject var model = MyModel.shared
    @StateObject var store = ManagedSettingsStore()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    init() {
//        FirebaseApp.configure()
//    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(model)
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
