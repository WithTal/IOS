//
//  SurveyGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation
import SwiftUI
import FamilyControls
import FirebaseFirestore

import Firebase
import FirebaseAuth


struct shortSurveyView: View {
    @Binding var currentScreen: AppScreen
    @State private var questionIndex = 0
    @State private var surveyResponse = SurveyResponse(addiction: "", hobby: "", profession: "", referral: "")

    
    struct SurveyResponse {
        var addiction: String
        var hobby: String
        var profession: String
        var referral: String
    }

//
//
//    struct SurveyResponse {
//        var answers: [String]
//    }

    
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
                    goToNextQuestion(selectedOption: option)
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
    
    func goToNextQuestion(selectedOption: String) {
        switch questionIndex {
        case 0:
            surveyResponse.addiction = selectedOption
        case 1:
            surveyResponse.hobby = selectedOption
        case 2:
            surveyResponse.profession = selectedOption
        case 3:
            surveyResponse.referral = selectedOption
        default:
            break
        }
        
        if questionIndex < questions.count - 1 {
            questionIndex += 1
        } else {
            // End the survey, save to Firestore, and go to contacts or results page
            saveSurveyData()
        }
    }

        func saveSurveyData() {
            guard let userID = Auth.auth().currentUser?.uid else {
                print("User not authenticated")
                return
            }
            let db = Firestore.firestore()
            
            db.collection("userdetails").document(userID).collection("userSurvey").addDocument(data: [
                "addiction": surveyResponse.addiction,
                "hobby": surveyResponse.hobby,
                "profession": surveyResponse.profession,
                "referral": surveyResponse.referral
            ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                    currentScreen = .contacts
                }
            }
        }

}


