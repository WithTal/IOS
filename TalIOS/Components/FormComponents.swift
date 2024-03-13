//
//  FormComponents.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct ReusableInputComponent: View {
    @Binding var text: String

    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .placeholder(when: text.isEmpty) {
                Text(placeholder).foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
            }
            .padding()
            .frame(maxWidth: .infinity)
                    .background(Color(.black))
                    .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 1)
                                )
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6)) // #999999)

    }
}


//struct ContentView: View {
//    @State private var email = ""
//
//    var body: some View {
//        ReusableInputComponent(text: $email, placeholder: "Your Email")
//    }
//}


struct DividerWithText: View {
    var text: String
    
    var body: some View {
        HStack {
            line
            Text(text).foregroundColor(.gray)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(Color.gray) }
    }
}
