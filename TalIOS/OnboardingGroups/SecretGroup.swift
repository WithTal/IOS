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
            buttonText: "Next",
            buttonAction: {
                print("Secrets -> Next button pressed")
                currentScreen = .initialApps
            },
            alignLeft: true
            
        ) {
            SecretsView()
            // Placeholder for List of secrets to add and default ones
//            Text("List of secrets to add and default ones Content")
        }
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
        secrets.append(newSecret)
    }
}

extension SecretsViewModel {
    func addRandomSecret() {
        let randomSecrets = ["Secret A", "Secret B", "Secret C", "Secret D"] // Example secrets
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

    var body: some View {
        VStack(spacing: 10) {
            // ReusableInputComponent for new secret input
            ReusableInputComponent(text: $newSecretText, placeholder: "Enter a new secret")
            Button("Add Secret") {
                viewModel.addSecret(newSecretText)
                newSecretText = ""
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)

            DividerWithText(text: "Your Secrets")
                .padding(.vertical)

            Button("Add Random Secret") {
                viewModel.addRandomSecret()
            }
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
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}






