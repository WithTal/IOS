//
//  AppBlock.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/16/24.
//

import Foundation
import SwiftUI

import SwiftUI


struct NewBlockView: View {
    @State private var selectedApps: [String] = []
    @State private var unlocksAllowed: Int = 5
    @State private var unlockDuration: Int = 5
    @State private var difficulty: String = "Normal"
    @State private var activeDays: [Bool] = [true, true, true, true, true, true, true]
    @State private var modeSelection: String = "Schedule"
    @State private var showingDifficultySettings = false
    @State private var showingDurationSelection = false

    
    @State private var selectedTheme = "Dark"
    let themes = ["Easy", "Medium", "Hard"]


    var body: some View {
        NavigationView {
            Form {
                
                
                Section(header: Text("App Group")) {
                    NavigationLink(destination: SelectAppsView(selectedApps: $selectedApps)) {
                        SettingRow(title: "Group", value: selectedApps.isEmpty ? "Pick a group" : "\(selectedApps.count) Apps")
                    }
                }
                
                Section(header: Text("App Lock Settings")) {
                    Picker("Mode", selection: $modeSelection) {
                        Text("Schedule").tag("Schedule")
                        Text("For Now").tag("For Now")
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if modeSelection == "Schedule" {
                        Button("Session Time") {
                            showingDurationSelection = true
                        }
                        .sheet(isPresented: $showingDurationSelection) {
                            DurationSelectionView(unlockDuration: $unlockDuration)
                        }

                        // Schedule specific settings
                        NavigationLink(destination: SelectAppsView(selectedApps: $selectedApps)) {
                            SettingRow(title: "Schedule", value: selectedApps.isEmpty ? "No Apps" : "\(selectedApps.count) Apps")
                        }
                    }
                    
                    else {
                        Stepper(value: $unlocksAllowed, in: 1...10) {
                            SettingRow(title: "Time to lock", value: "\(unlocksAllowed)m")
                        }
                    }
                    Button("Difficulty") {
                        showingDifficultySettings = true
                    }
                    .sheet(isPresented: $showingDifficultySettings) {
                        DifficultySettingsView(selectedDifficulty: $difficulty)
                            .presentationDetents([.medium, .large]) // Define the detents you want

                    }


                    
                }

                Button("Save") {
                    // Save functionality based on selected mode
                }
                .buttonStyle(SaveButtonStyle())
            }
            .navigationBarTitle("App Lock", displayMode: .inline)
        }
    }
}

struct DurationSelectionView: View {
    @Binding var unlockDuration: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var hours: Int = 0
    @State private var minutes: Int = 20
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Duration")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Text("Select how long this event should last.")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom)

            HStack {
                Spacer()
                Text("hours")
                    .foregroundColor(.gray)
                Spacer()
                Spacer()
                Text("minutes")
                    .foregroundColor(.gray)
                Spacer()
            }

            
//            HStack {
//
//                Text("hours")
//                    .foregroundColor(.gray)
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    .padding(.trailing)
//
////                Spacer()
//
//                Text("minutes")
//                    .foregroundColor(.gray)
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
//                    .padding(.leading)
//
//            }
            

            HStack {
                Picker("Hours", selection: $hours) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .compositingGroup()
                .pickerStyle(WheelPickerStyle())
                
                Picker("Minutes", selection: $minutes) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)").tag(minute)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .compositingGroup()
                .pickerStyle(WheelPickerStyle())
            }
            .background(Color.black)

//            Spacer()
            
            HStack {
                Button("Always On") {
                    hours = 0
                    minutes = 0
                    confirmSelection()
                }
                .foregroundColor(.gray)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                
                Button("Confirm") {
                    confirmSelection()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func confirmSelection() {
        unlockDuration = hours * 60 + minutes
        presentationMode.wrappedValue.dismiss()
    }
}



struct DifficultySettingsView: View {
    @Binding var selectedDifficulty: String
    @Environment(\.presentationMode) var presentationMode

    let difficulties = [
        ("Normal", "You can snooze and cancel this session", "moon.fill"),
        ("Timeout", "There will be increasing delays before you can snooze again", "timer"),
        ("Deep Focus", "You can't snooze or end the session early", "figure.walk")
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("Session Difficulty")
                .font(.headline)
                .padding()

            ForEach(difficulties, id: \.0) { (difficulty, description, icon) in
                Button(action: {
                    self.selectedDifficulty = difficulty
                }) {
                    HStack {
                        Image(systemName: icon)
                            .frame(width: 20, height: 20)
                            .padding(.trailing)

                        VStack(alignment: .leading) {
                            Text(difficulty)
                                .fontWeight(.medium)
                            Text(description)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        if selectedDifficulty == difficulty {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.secondarySystemBackground)))
                    .padding(.horizontal)
                }
                .padding(.vertical, 8) // Vertical margin between buttons; adjust the 8 to your preference

                .buttonStyle(PlainButtonStyle())
            }
            Spacer()
            
            Button("Save") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}


// Custom row for settings
struct SettingRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

// Custom view for selecting apps
struct SelectAppsView: View {
    @Binding var selectedApps: [String]

    var body: some View {
        // Dummy view for app selection
        Text("App Selection Screen")
    }
}

// Custom view for selecting duration
struct SelectDurationView: View {
    @Binding var unlockDuration: Int

    var body: some View {
        // Dummy view for duration selection
        Text("Duration Selection Screen")
    }
}

// Custom view for selecting difficulty
struct SelectDifficultyView: View {
    @Binding var difficulty: String

    var body: some View {
        // Dummy view for difficulty selection
        Text("Difficulty Selection Screen")
    }
}

// Custom view for selecting days of the week
struct DaysOfWeekSelectionView: View {
    @Binding var activeDays: [Bool]
    let days = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        HStack {
            ForEach(days.indices, id: \.self) { index in
                Button(action: {
                    self.activeDays[index].toggle()
                }) {
                    Text(self.days[index])
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(self.activeDays[index] ? Color.blue : Color.gray)
                        .cornerRadius(15)
                }
            }
        }
    }
}

// Custom button style for Save button
struct SaveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color.green.opacity(0.8) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}

// Entry point
//struct ContentView: View {
//    var body: some View {
//        AppLockSettingsView()
//    }
//}

//// SwiftUI preview for development
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
