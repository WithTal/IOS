//
//  SecretGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/12/24.
//

import Foundation
import SwiftUI


struct SecretQuizView: View {
    @Binding var currentScreen: AppScreen

    var body: some View {
        ReusablePageView(
            topText: "Add embarrassing messages",
            subTopText: "If you miss your goals, we’ll send them to your friends 🙂",
            skippable: true,
            nextSkip: true,
        
            buttonAction: {
                print("Secrets -> Next button pressed")
                currentScreen = .initialApps
            },
            alignLeft:  true
            
        ) {
            SecretsView()
            // Placeholder for List of secrets to add and default ones
//            Text("List of secrets to add and default ones Content")
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat
    var shakesPerUnit: CGFloat
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * shakesPerUnit), y: 0))
    }
}




struct Secret: Identifiable, Hashable {
    let id = UUID()
    var content: String
}
class SecretsViewModel: ObservableObject {
    @Published var secrets: [Secret]

    init(secrets: [Secret] = [
//        Secret(content: "Predefined Secret 1"),
//                             Secret(content: "Predefined Secret 2")
    ]
    ) {
        self.secrets = secrets
    }

    func addSecret(_ secretContent: String) {
        let newSecret = Secret(content: secretContent)
        secrets.insert(newSecret, at: 0)
    }
}

extension SecretsViewModel {
    func addRandomSecret() {
        let randomSecrets = ["I'm a Trump supporter", "I dislike peanut butter", "ChatGPT is my therapist", "I sleep in"] // Example secrets
        let randomIndex = Int.random(in: 0..<randomSecrets.count)
        addSecret(randomSecrets[randomIndex])
    }

    func deleteSecret(at offsets: IndexSet) {
        secrets.remove(atOffsets: offsets)
    }
}



struct SecretsView: View {
    @StateObject var viewModel = SecretsViewModel()
    @State private var newSecretText: String = ""
    @State private var shake: Int = 0

    var body: some View {
        VStack(spacing: 10) {
            // ReusableInputComponent for new secret input
            ReusableInputComponent(text: $newSecretText, placeholder: "Enter a new secret")
                .modifier(ShakeEffect(amount: 10, shakesPerUnit: 3, animatableData: CGFloat(shake)))

            HStack {
                Button(action: {
                    if newSecretText.isEmpty {
                        withAnimation(.default) {
                            shake += 1
                        }
                    } else {
                        viewModel.addSecret(newSecretText)
                        newSecretText = ""
                    }
                }) {
                    HStack {
                        Image(systemName: "lock.fill") // Icon for the "New Secret" button
                        Text("New Secret")
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)

                Button(action: {
                    viewModel.addRandomSecret()
                }) {
                    HStack {
                        Image(systemName: "shuffle") // Icon for the "Random" button
                        Text("Random")
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
            }

           
            
            
            

            DividerWithText(text: "Your Secrets")
                .padding(.vertical)

            
//            .buttonStyle()
            // Style the button as per your preference

            // List of secrets with swipe to delete
            List {
                ForEach(viewModel.secrets) { secret in
                    Text(secret.content)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .onDelete(perform: viewModel.deleteSecret)
            }
            .listStyle(PlainListStyle())
        }
        .padding(.vertical)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}






