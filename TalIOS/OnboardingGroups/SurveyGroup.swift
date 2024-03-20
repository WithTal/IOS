//
//  SurveyGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation
import SwiftUI
import FamilyControls



struct shortSurveyView: View {
    @Binding var currentScreen: AppScreen
    @State private var questionIndex = 0
    
    

    // Define your questions and options
    let questions = [
        "How many hours are you on your phone a day",
        "Favorite hobby?",
        "Profession",
        "How did you find Tal?"
    ]
    
    let options = [
        ["1", "2-3", "4-5", "6+"],
        ["Music", "Movies", "Reading", "Cooking", "Other"],
        ["Student", "Engineer", "Marketing", "Blue collar"],
        ["Social media", "Founder", "Friend", "Ad"]
    ]
    
    var body: some View {
        VStack {
            // Progress Indicator
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(index < questionIndex ? .white : .gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom)
            
            
            Text(questions[questionIndex])
                .font(.title)
                .padding()
            
            // Display options as buttons
            ForEach(options[questionIndex], id: \.self) { option in
                
                
                Button(action: {
                    // Handle selection
                    goToNextQuestion()
                }) {
                    Text(option)
                        .frame(maxWidth: .infinity) // Make the Text fill the button's frame
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.098, green: 0.098, blue: 0.098) )
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                
            }
            
            Spacer()
            
            // Skip button
            Button("Skip") {
                print("Short Survey -> Skip button pressed")
                currentScreen = .contacts
            }
            .padding()
        }
        .padding()
    }
    
    // Function to go to the next question or end the survey
    func goToNextQuestion() {
        if questionIndex < questions.count - 1 {
            questionIndex += 1
        } else {
            // End the survey, go to contacts or results page
            currentScreen = .contacts
        }
    }
}


