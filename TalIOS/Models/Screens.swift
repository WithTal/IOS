//
//  Screens.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/16/24.
//

import Foundation
import FamilyControls
import ManagedSettings

//private let _MyModel = MyModel()
//
//class MyModel: ObservableObject {
//    // Import ManagedSettings to get access to the application shield restriction
//    let store = ManagedSettingsStore()
//    //@EnvironmentObject var store: ManagedSettingsStore
//
//    @Published var selectionToDiscourage: FamilyActivitySelection
//    @Published var selectionToEncourage: FamilyActivitySelection
//
//    init() {
//        selectionToDiscourage = FamilyActivitySelection()
//        selectionToEncourage = FamilyActivitySelection()
//    }
//
//    class var shared: MyModel {
//        return _MyModel
//    }
//
//    func setShieldRestrictions() {
//        // Pull the selection out of the app's model and configure the application shield restriction accordingly
//        let applications = MyModel.shared.selectionToDiscourage
//
//
//        print("DISCOURAGING")
//        print(applications)
//
//        if !discourageSelection.applicationTokens.isEmpty {
//              store.shield.applications = discourageSelection.applicationTokens
//          }
//          if !discourageSelection.categoryTokens.isEmpty {
//              // Assuming the following line is the correct way to set categories if specific tokens are available
//              store.shield.applicationCategories = .specific(discourageSelection.categoryTokens)
//          }
//
//
////        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
//        store.shield.applicationCategories = applications.categoryTokens.isEmpty
//        ? nil
//        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
//
//
//
//    }
//}

import Foundation
import FamilyControls
import ManagedSettings

//private let _MyModel = MyModel()
//
//class MyModel: ObservableObject {
//    // Import ManagedSettings to get access to the application shield restriction
//    let store = ManagedSettingsStore()
//    //@EnvironmentObject var store: ManagedSettingsStore
//
//    @Published var selectionToDiscourage: FamilyActivitySelection
//    @Published var selectionToEncourage: FamilyActivitySelection
//
//    init() {
//        selectionToDiscourage = FamilyActivitySelection()
//        selectionToEncourage = FamilyActivitySelection()
//    }
//
//    class var shared: MyModel {
//        return _MyModel
//    }
//
//    func setShieldRestrictions() {
//        // Pull the selection out of the app's model and configure the application shield restriction accordingly
//        var applications = MyModel.shared.selectionToDiscourage
//
////        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
////        store.shield.applicationCategories = applications.categoryTokens.isEmpty
////        ? nil
////        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
//    }
//}
import Foundation
import FamilyControls
import ManagedSettings

private let _MyModel = MyModel()

class MyModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let store = ManagedSettingsStore()
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var selectionToEncourage: FamilyActivitySelection
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
        selectionToEncourage = FamilyActivitySelection()
    }
    
    class var shared: MyModel {
        return _MyModel
    }
    
    func setShieldRestrictions() {
        print("setShieldRestrictions")
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = MyModel.shared.selectionToDiscourage
        if applications.applicationTokens.isEmpty {
            print("empty applicationTokens")
        }
        if applications.categoryTokens.isEmpty {
            print("empty categoryTokens")
        }
        
//        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
//        store.shield.applicationCategories = applications.categoryTokens.isEmpty
//        ? nil
//        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
}
