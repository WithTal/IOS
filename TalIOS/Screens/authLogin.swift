//
//  authLogin.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation


import SwiftUI

struct LoginView2: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Opal")
                .font(.largeTitle)
                .padding()
            
            Text("Welcome back")
                .font(.title2)
                .padding(.bottom, 5)
            
            Text("Let's get you in to Opal")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextField("Your Email", text: $email)
                .padding()
            
//                .background(Color.secondary.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal, 32)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Apply the rounded border style to this text field

//
//            TextField("Your Email", text: $email)
//                .padding()
//                .background(Color.secondary.opacity(0.3))
//                .cornerRadius(5)
//                .padding(.horizontal, 32)
            
            SecureField("Your Password", text: $password)
                
                .padding(.all, 2)
                .background(Color.secondary.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal, 32)
            
            Button("Forgot password?", action: {
                // Handle forgot password action
            })
            .padding(.top, 5)
            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)) // #99999
            
            Button("Sign in", action: {
                // Handle sign in action
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.horizontal, 32)
            
            Text("or")
                .foregroundColor(.gray)
                .padding()
            Group {
                VStack {
                    Button(action: {
                        // Handle Sign In With Apple
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign In With Apple")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.098, green: 0.098, blue: 0.098)) // #191919)
                        .cornerRadius(5)
                    }
                    
                    Button(action: {
                        // Handle Sign In With Phone
                    }) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Sign In With Phone")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.098, green: 0.098, blue: 0.098)) // #191919)
                        .cornerRadius(5)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button("Sign up", action: {
                        // Handle sign up action
                    })
                    .foregroundColor(.blue)
                }
                .padding(.bottom)
            }

            // Add any additional views or functionality as needed

        }
        .background(Color.black) // Set the background color of the VStack to black
        .edgesIgnoringSafeArea(.all) // Make the background ignore the safe area to extend to the edges
        .foregroundColor(.white) // Set the default text color to white inside the VStack
        .textFieldStyle(RoundedBorderTextFieldStyle()) // This may not have the desired effect on the styling
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//
//
//
