//
//  AuthGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation
import SwiftUI



struct TestView: View {
    @Binding var currentScreen: AppScreen

    var body: some View {
        ReusablePageView(
            topText: "TESTING",
            subTopText: "Join the best movement ever.",
            skippable: false,
            buttonAction: {
                print("Test -> Button pressed")
                currentScreen = .login // Change screen
            },
            logo: true
        ) {
            Text("Test Content")
        }
    }
}

struct LoginView:  View {
    @Binding var currentScreen: AppScreen
    var body: some View {
        ReusablePageView(
            topText: "Welcome back",
            subTopText: "Let’s get you into Tal ", skippable: false,
            buttonAction: {
                print("Authentication/Login -> Next button pressed")
                currentScreen = .register
            },
            logo: true
        ) {
            // Placeholder for Sign in Functionality
            Text("Sign in Functionality Content")
        }
    }
}


struct RegisterView:  View {
    @Binding var currentScreen: AppScreen
    
    var body: some View {
        ReusablePageView(
            topText: "Let’s create your account",
            subTopText: "Join the best movement ever.", skippable: false,
            
            buttonAction: {
                print("Authentication/Login -> Next button pressed")
                currentScreen = .shortSurvey
            },
            logo: true
        ) {
            // Placeholder for Sign in Functionality
            Text("Sign in Functionality Content")
        }
    }
   }


