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
        @State private var email = ""
    //
    //    var body: some View {
    //        ReusableInputComponent(text: $email, placeholder: "Your Email")
    //    }

    
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
            VStack(spacing: 15){
                ReusableInputComponent(text: $email, placeholder: "Your Email")
                ReusableInputComponent(text: $email, placeholder: "Password")
                Text("Forgot password?").foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                Button("Sign In") {
                    currentScreen = .shortSurvey
                    print("Button tapped!")
                }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(25)
//                    .padding(.horizontal, 32)
//                    .padding(.bottom, 20)
                
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
                
                
//                Button("Sign In with Apple") {
//                    print("Button tapped!")
//                }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                    .foregroundColor(.white)
                    .cornerRadius(25)
//                    .padding(.horizontal, 32)
//                    .padding(.bottom, 20)
                
                Button(action: {
                            print("Sign In with Phone")
                        }) {
                            HStack {
                                Image(systemName: "phone.fill") // SF Symbols icon
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20) // Adjust the size as needed
                                Text("Sign In with Phone")
                            }
                        }
                
                
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                    .foregroundColor(.white)
                    .cornerRadius(25)
//                    .padding(.horizontal, 32)
//                    .padding(.bottom, 20)

                Button("Don't have an account?"){
                    print("REGISTER SCREEN")
                    currentScreen = .register
                }.foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
            }
            
            // Placeholder for Sign in Functionality
//            Text("Sign in Functionality Content")
            
        }
    }
}


struct RegisterView:  View {
    @Binding var currentScreen: AppScreen
    
        @State private var email = ""
    var body: some View {
        ReusablePageView(
            topText: "Let's create your account",
            subTopText: "Join us in a mythical journey ", skippable: false,
            buttonAction: {
                print("Authentication/Login -> Next button pressed")
                currentScreen = .login
            },
            logo: true
        ) {
            VStack(spacing: 15){
                ReusableInputComponent(text: $email, placeholder: "Your Email")
                ReusableInputComponent(text: $email, placeholder: "Password")
                Text("Forgot password?").foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)).font(.subheadline)
                Button("Sign Up") {
                    currentScreen = .shortSurvey
                    print("Button tapped!")
                }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(25)
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
                            print("Sign Up with Phone")
                        }) {
                            HStack {
                                Image(systemName: "phone.fill") // SF Symbols icon
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20) // Adjust the size as needed
                                Text("Sign Up with Phone")
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
            
            // Placeholder for Sign in Functionality
//            Text("Sign in Functionality Content")
            
        }
    }
   }


