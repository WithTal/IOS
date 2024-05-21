//
//  AuthGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation
import SwiftUI

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI
import AuthenticationServices
import CryptoKit
import FirebaseAuth


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

import CryptoKit

//import FirebaseCore
import FirebaseAuth

//import Firebase



struct LoginView: View {
    @Binding var currentScreen: AppScreen
    @State private var email = ""
    @State private var password = ""  // Add a state for password
    



    
    
    
    private func startGoogleSignIn() {
        
        print("SIGNING")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        //        print(clientId)
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {result, error in
            guard error == nil else {
                print("ERROR")
                print(error)
                return
                // ...
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("RETURNING")
                return
                // ...
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            currentScreen = .shortSurvey
            // ...
        }
        
    }

        // Function to retrieve the root view controller
    private func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
    }
    

    
    
    var body: some View {
        ReusablePageView(
            topText: "Welcome back",
            subTopText: "Let’s get you into Tal",
            skippable: false,
            buttonAction: {
                print("Authentication/Login -> Next button pressed")
                currentScreen = .register
            },
            logo: true
        ) {
            VStack(spacing: 15) {
                ReusableInputComponent(text: $email, placeholder: "Your Email")
                ReusableInputComponent(text: $password, placeholder: "Password") // Use for password
                Text("Forgot password?").foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                
                Button("Sign In") {
                    signInWithEmail(email: email, password: password)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(25)
                
                DividerWithText(text: "or")
                    .padding()
                
                Button(action: {
                    print("Sign in with Apple")
                }) {
                    HStack {
                        Image(systemName: "apple.logo") // SF Symbols icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20) // Adjust the size as needed
                        Text("Sign In with Apple")
                    }
                }
                
                
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                .foregroundColor(.white)
                .cornerRadius(25)
                
                Button(action: {
                    
                    print("Sign In with Google")
                    startGoogleSignIn()
                    
                }) {
                    HStack {
                        Image("Google Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height:20) // You can adjust the size as needed

                        Text("Sign In with Google")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                .foregroundColor(.white)
                .cornerRadius(25)
                
                Button("Don't have an account?"){
                    print("REGISTER SCREEN")
                    currentScreen = .register
                }.foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
            }
        }
        .onAppear {
            // Call the function to apply the shield here
            applyShields()
            
        }
    }
    
    private func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error in sign in: \(error.localizedDescription)")
                // Handle error - show alert or message to user
            } else {
                // Authentication successful
                currentScreen = .shortSurvey
            }
        }
    }
}


struct RegisterView: View {
    @Binding var currentScreen: AppScreen
    @State private var email = ""
    @State private var password = ""  // Add a state for password

    
    private func startGoogleSignIn() {
        
        print("SIGNING")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        //        print(clientId)
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {result, error in
            guard error == nil else {
                return
                // ...
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
                // ...
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            currentScreen = .shortSurvey
            // ...
        }
        
    }

        // Function to retrieve the root view controller
    private func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
    }
    
    var body: some View {
        ReusablePageView(
            topText: "Let's create your account",
            subTopText: "Join us in a mythical journey", skippable: false,
            buttonAction: {
                signUpWithEmail(email: email, password: password)
            },
            logo: true
        ) {
            VStack(spacing: 15){
                ReusableInputComponent(text: $email, placeholder: "Your Email")
                ReusableInputComponent(text: $password, placeholder: "Password") // Use for password
                Text("Forgot password?").foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                
                Button("Sign Up") {
                    signUpWithEmail(email: email, password: password)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(25)
                
                
                
                
                //struct RegisterView:  View {
                //    @Binding var currentScreen: AppScreen
                //
                //        @State private var email = ""
                //    var body: some View {
                //        ReusablePageView(
                //            topText: "Let's create your account",
                //            subTopText: "Join us in a mythical journey ", skippable: false,
                //            buttonAction: {
                //                print("Authentication/Login -> Next button pressed")
                //                currentScreen = .login
                //            },
                //            logo: true
                //        ) {
                //            VStack(spacing: 15){
                //                ReusableInputComponent(text: $email, placeholder: "Your Email")
                //                ReusableInputComponent(text: $email, placeholder: "Password")
                //                Text("Forgot password?").foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                //                Button("Sign Up") {
                //                    currentScreen = .shortSurvey
                //                    print("Button tapped!")
                //                }
                //                    .padding()
                //                    .frame(maxWidth: .infinity)
                //                    .background(Color.white)
                //                    .foregroundColor(.black)
                //                    .cornerRadius(25)
                //                    .padding(.horizontal, 32)
                //                    .padding(.bottom, 20)
                
                DividerWithText(text: "or")
                    .padding()
                
                Button(action: {
                    print("Sign Up with Apple")
                }) {
                    HStack {
                        Image(systemName: "apple.logo") // SF Symbols icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20) // Adjust the size as needed
                        Text("Sign Up with Apple")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                .foregroundColor(.white)
                .cornerRadius(25)
                //                    .padding(.horizontal, 32)
                //                    .padding(.bottom, 20)
                
                Button(action: {
                    
                    print("Sign In with Google")
                    startGoogleSignIn()
                    
                }) {
                    HStack {
                        Image("Google Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height:20) // You can adjust the size as needed

//                        Image(systemName: "shazam.logo") // SF Symbols icon
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 20) // Adjust the size as needed
                        Text("Sign Up with Google")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                .foregroundColor(.white)
                .cornerRadius(25)
                //                    .padding(.horizontal, 32)
                //                    .padding(.bottom, 20)
                
                Button("Already have an account?"){
                    print("LOGIN SCREEN")
                    currentScreen = .login
                }.foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                
                
            }
        }
    }
    
        
        // Placeholder for Sign in Functionality
        //            Text("Sign in Functionality Content")
        private func signUpWithEmail(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error in sign up: \(error.localizedDescription)")
                    // Handle error - show alert or message to user
                } else {
                    print("SIGNED Up")
                    // Sign up successful
                    currentScreen = .shortSurvey
                }
            }
        }
}


