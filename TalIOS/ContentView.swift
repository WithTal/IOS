//
//  ContentView.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/6/24.
//

import SwiftUI
import CoreData
import FirebaseAuth


//struct AppGroupListView: View {
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \AppGroup.name, ascending: true)],
//        animation: .default)
//    private var appGroups: FetchedResults<AppGroup>
//
//    var body: some View {
//        List {
//            Text("IH")
//
//            ForEach(appGroups) { group in
//                Text(group.name ?? "Unnamed Group")
//                // Navigate to details or modify the group
//            }
//            .onDelete(perform: deleteAppGroups)
//        }
//    }
//
//    private func deleteAppGroups(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { appGroups[$0] }.forEach(viewContext.delete)
//            do {
//                try viewContext.save()
//            } catch {
//                // Handle the error
//            }
//        }
//    }
//
//    // Inject the managed object context
//    @Environment(\.managedObjectContext) private var viewContext
//}

struct FamilyActivitySelection {
    var applicationTokens: [String] = []
    var categoryTokens: [String] = []
    var webDomains: [String] = []
    
    // Initialize with applications, categories, and web domains, if necessary
    // This could be from a user's selection or a default setting
    init(applications: [String] = [], categories: [String] = [], webDomains: [String] = []) {
        self.applicationTokens = applications
        self.categoryTokens = categories
        self.webDomains = webDomains
    }

//
//    var applications: [String] = []
//    var categories: [String] = []
//    var webDomains: [String] = []
}

struct FamilyActivityPickerModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection
    
    func body(content: Content) -> some View {
        // Implementation of the FamilyActivityPicker goes here.
        // This would be a custom UI component that acts as a picker.
        // Since it's not a part of Swift's native view library, we assume it's a custom implementation.
        content
    }
}

extension View {
    func familyActivityPicker(isPresented: Binding<Bool>, selection: Binding<FamilyActivitySelection>) -> some View {
        self.modifier(FamilyActivityPickerModifier(isPresented: isPresented, selection: selection))
    }
}
//
//struct AppSelectionView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \AppApp.name, ascending: true)],
//        animation: .default)
//    private var availableApps: FetchedResults<AppApp>
//
//    @State private var selectedAppIDs: Set<UUID> = []
//    @State var familyActivitySelection = FamilyActivitySelection()
//    @State var isPresented = false
//
//    var body: some View {
//        List(availableApps, id: \.self) { app in
//            Button(app.name ?? "Unknown") {
//                if let appID = app.id {
//                    if selectedAppIDs.contains(appID) {
//                        selectedAppIDs.remove(appID)
//                    } else {
//                        selectedAppIDs.insert(appID)
//                    }
//                }
//            }
//        }
//        .familyActivityPicker(isPresented: $isPresented, selection: $familyActivitySelection)
//        .onChange(of: familyActivitySelection.applications) { newSelection in
//            // Filter availableApps based on the selection
//            let filteredApps = availableApps.filter { familyActivitySelection.applications.contains($0.name ?? "") }
//            selectedAppIDs = Set(filteredApps.compactMap { $0.id })
//        }
//
//        Button("Present FamilyActivityPicker") { isPresented = true }
//
//        Button("Add to Group") {
//            addAppsToGroup()
//        }
//    }
//
//    private func addAppsToGroup() {
//        let group = AppGroup(context: viewContext) // Or fetch an existing group
//
//        var appsToAdd: [AppApp] = []
//        for appID in selectedAppIDs {
//            if let app = availableApps.first(where: { $0.id == appID }) {
//                appsToAdd.append(app)
//            }
//        }
//
//        group.apps = NSSet(array: appsToAdd)
//
//        do {
//            try viewContext.save()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}




//struct AppInfo: Identifiable {
//    let name: String
//
//    let id: String // Ensure this is unique for each app
//}
//
//
//struct AppSelectionView2: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \AppApp.name, ascending: true)],
//        animation: .default)
//    private var availableApps: FetchedResults<AppApp>
//
//    @State private var selectedAppIDs: Set<UUID> = []
//
//    var body: some View {
//        List(availableApps, id: \.self) { app in
//            Button(app.name ?? "Unknown") {
//                // Ensure that we only insert non-nil UUIDs into the selectedAppIDs set
//                if let appID = app.id {
//                    if selectedAppIDs.contains(appID) {
//                        selectedAppIDs.remove(appID)
//                    } else {
//                        selectedAppIDs.insert(appID)
//                    }
//                }
//            }
//        }
//
//        Button("Add to Group") {
//            print(availableApps)
//            addAppsToGroup()
//        }
//    }
//
//    private func addAppsToGroup() {
//        let group = AppGroup(context: viewContext) // Or fetch an existing group
//
//        // Create an array to collect all apps that need to be added
//        var appsToAdd: [AppApp] = []
//        for appID in selectedAppIDs {
//            if let app = availableApps.first(where: { $0.id == appID }) {
//                appsToAdd.append(app)
//            }
//        }
//
//        // Add the apps to the group's apps relationship
//        group.apps = NSSet(array: appsToAdd)
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Handle save error
//            print(error.localizedDescription)
//        }
//    }

//}

struct AppGroupListView: View {
    @FetchRequest(
        entity: AppGroup.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \AppGroup.name, ascending: true)]
    ) var appGroups: FetchedResults<AppGroup>

    var body: some View {
        List(appGroups, id: \.self) { group in
            Text(group.name ?? "Unknown")
            // Navigate to detail or modification view
        }
    }
}



struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showOnboarding = false
    @State private var testing = true

    var body: some View {
        Group {
            
//            if testing {
////                OnboardingView(showOnboarding: $showOnboarding)
////                Text()
//                AppSelectionView()
//            }
//            else {
                if !showOnboarding {
                    OnboardingView(showOnboarding: $showOnboarding)
                } else  {
                    HomeView(showOnboarding: $showOnboarding)
                }
//            }
        }
        .onAppear {
            checkIfLoggedIn()
        }
    }

    private func checkIfLoggedIn() {
        // Check if the user is logged in
        if Auth.auth().currentUser != nil {
            // User is logged in, do not show onboarding
            showOnboarding = false
        } else {
            // No user is logged in, show onboarding
            showOnboarding = true
        }
    }

    
    
//    var body: some View {
//        if showOnboarding {
//            OnboardingView(showOnboarding: $showOnboarding)
//        } else {
//            HomeView(showOnboarding: $showOnboarding)
//        }
////        OnboardingView()
//    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
