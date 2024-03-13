//
//  OnboardingLayout.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation

import SwiftUI

// Define a reusable view that has placeholders for top, sub-top, content, and a bottom button.
struct ReusablePageView<Content: View>: View {
    let topText: String
    let subTopText: String
    let skippable: Bool
    var buttonText: String?
    var buttonAction: () -> Void // Closure type for button action
    var logo: Bool?
    var alignLeft: Bool?
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                if skippable{
                    HStack {
                        Spacer()
                        
                        Text("Skip").padding([.leading])
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4)) // #666666)
                    }
                    
                    
                }
                
                if let showLogo = logo, showLogo{
                    HStack {
                        //                    Spacer()
                        Image("T")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width / 2) // Set the width to half of the screen width
                            .padding()
                                                
                    }
                    
                }
                
                if let differentAlignment =  alignLeft, differentAlignment{
                    Text(topText)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 10) // Adjust the padding to move the text closer to the top safe area
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .edgesIgnoringSafeArea(.top)
                        .foregroundColor(.white)
                }
                else {
                    Text(topText)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 10) // Adjust the padding to move the text closer to the top safe area
                        .frame(maxWidth: .infinity, alignment: .center)
                        .edgesIgnoringSafeArea(.top)
                        .foregroundColor(.white)

                    
                }
                
                //            Text(topText)
                //                .font(.title)
                //                .padding(.bottom, 2)
                if let differentAlignment =  alignLeft, differentAlignment{
                    Text(subTopText)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)) // #cccccc
                        .padding(.bottom, 20)
                }
                else {
                    Text(subTopText)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)) // #cccccc
                        .padding(.bottom, 20)
                }
                content
            
                
                Spacer()
                
                if let text=buttonText{
                    Button(text, action: buttonAction)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20)
                }
//                else {
//                    Button("temporary", action: buttonAction)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.white)
//                        .foregroundColor(.black)
//                        .cornerRadius(25)
//                        .padding(.horizontal, 32)
//                        .padding(.bottom, 20)
//                }
            }
            .background(Color.black) // Set the background color of the VStack to black
            .edgesIgnoringSafeArea(.all) // Make the background ignore the safe area to extend to the edges
            .foregroundColor(.white) // Set the default text color to white inside the VStack
            .padding(.vertical, 20) // This adds vertical padding to the top and bottom inside the VStack
            .padding(.horizontal, 20)
            
        }
    }
}



enum AppScreen {
    case login
    case register
    case shortSurvey
    case contacts
    case contacts2
    case secrets
//    case contacts
    case initialApps
        
    case initialApps2
        
    
    case initialApps3
        
    case explanationOfBlocks
    case test
        
//    case welcome
//    case signUp
    // Add other cases for each screen you want to navigate through
}

struct OnboardingView: View {
    @State private var currentScreen: AppScreen = .register
    @Binding var showOnboarding: Bool

//    var body: some View {
//        VStack {
//            switch currentScreen {
//            case .welcome:
//                welcomeView
//            case .login:
//                loginView
//            case .signUp:
//                signUpView
//            // Add cases for other screens here
//            }
//        }
//        .transition(.slide) // Adds a simple transition animation between screens
//    }

    var body: some View {
            VStack {
                switch currentScreen {
                    
//                    set
                case .login:
                    LoginView(currentScreen: $currentScreen)
                case .register:
                    RegisterView(currentScreen: $currentScreen)
                    
//                    set
                case .shortSurvey:
                    shortSurveyView(currentScreen: $currentScreen)

//                    set
                case .contacts:
                    ContactsPreview(currentScreen: $currentScreen)
                case .contacts2:
                    ContactsView(currentScreen: $currentScreen)
                    
                    
                case .secrets:
                    SecretQuizView(currentScreen: $currentScreen)
                    
                case .initialApps:
                    initialAppsView
                case .initialApps2:
                    initialApps2View(currentScreen: $currentScreen)
                case .initialApps3:
                    initialApps3View
                    
                    
                case .explanationOfBlocks:
                    explanationOfBlocksView
                    
                    
                case .test:
                    TestView(currentScreen: $currentScreen)
                }
            }
        }

    

      

       
       var contacts2View: some View {
           ReusablePageView(
               topText: "Add your friends to see their screen time",
               subTopText: "You thought your screen time was bad?", skippable: false,
               buttonText: "Next",
               buttonAction: {
                   print("Contacts #2 -> Next button pressed")
                   currentScreen = .contacts2
               },
               alignLeft: true
           ) {
                              // Placeholder for Searchable scroll of contacts with emojis
               Text("Content")
           }
       }

       var initialAppsView: some View {
           ReusablePageView(
               topText: "Now let's get focused",
               subTopText: "Select up to 5 distracting apps and we'll block them", skippable: false,
               buttonText: "Next",
               buttonAction: {
                   print("Initial Apps -> Next button pressed")
                   currentScreen = .initialApps2
               }
           ) {
               // Placeholder for [Graphic of distracting apps]
               Text("[Graphic of distracting apps Content]")
           }
       }


       var initialApps3View: some View {
           ReusablePageView(
               topText: "Select your daily limits for these apps",
               subTopText: "Here you can set the number of pickups, duration per pickup!", skippable: false,
               buttonText: "Next",
               buttonAction: {
                   print("Initial Apps 3 -> Next button pressed")
                   currentScreen = .explanationOfBlocks
               }
           ) {
               // Placeholder for Select number of pickups and duration per pickup
               Text("Select number of pickups and duration per pickup Content")
           }
       }

       var explanationOfBlocksView: some View {
           ReusablePageView(
               topText: "One last thing: You can also do a “screen time pause”",
               subTopText: "This will block any set of apps for any period", skippable: false,
               buttonText: "All set!",
               buttonAction: {
                   print("Explanation of Blocks -> All set button pressed")
                   showOnboarding = false

                   // Navigate to the next screen or dismiss
               }
           ) {
               // Placeholder for screen time pause explanation
               Text("Explain screen time pause levels Content")
           }
       }


    // Add other views for different screens
}



// Usage example of ReusablePageView with a TextField and Button for login.
//struct LoginView2: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//        ReusablePageView(
//            topText: "Welcome back man",
//            subTopText: "Let's get you into Opal",
//            skippable: false,
//            buttonText: "Next",
//            buttonAction: {
//                // Define the action for your button here
//            }
//        ) {
//            VStack {
//                TextField("Your Email", text: $email)
//                    .padding()
//                    .background(Color.secondary.opacity(0.3))
//                    .cornerRadius(5)
//                    .padding(.horizontal, 32)
//
//                SecureField("Your Password", text: $password)
//                    .padding()
//                    .background(Color.secondary.opacity(0.3))
//                    .cornerRadius(5)
//                    .padding(.horizontal, 32)
//
//                // ... Include other login related content
//            }
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        LoginView()
//    }
//}

//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}







//
//
//import Contacts
//
//
//struct Contact: Identifiable {
//    let id: String
//    let name: String
//    let detail: String
//    let isFriend: Bool
//}
//
//class ContactsViewModel: ObservableObject {
//    @Published var contacts: [Contact] = []
//
//    private let store = CNContactStore()
//
//    func requestAccess() {
//        store.requestAccess(for: .contacts) { granted, error in
//            if let error = error {
//                print("Failed to request access", error)
//                return
//            }
//            if granted {
//                self.loadContacts()
//            } else {
//                print("Access denied")
//            }
//        }
//    }
//
//    func loadContacts() {
//        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//
//        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
//        do {
//            try store.enumerateContacts(with: request, usingBlock: { (cnContact, stop) in
//                // Assume everyone is not a friend for the example
//                let contact = Contact(id: cnContact.identifier,
//                                      name: "\(cnContact.givenName) \(cnContact.familyName)",
//                                      detail: (cnContact.phoneNumbers.first?.value.stringValue) ?? "",
//                                      isFriend: false)
//                self.contacts.append(contact)
//            })
//        } catch let error {
//            print("Failed to fetch contact, error: \(error)")
//        }
//    }
//}
//
//
//struct ContactsView: View {
//    @ObservedObject var viewModel = ContactsViewModel()
//
//    var body: some View {
//        List(viewModel.contacts) { contact in
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(contact.name) // Displays the contact's name
//                        .font(.headline)
//                    Text(contact.detail) // Displays the contact's detail, e.g., phone number
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                if contact.isFriend {
//                    Text("Friends") // This can be customized based on your logic
//                        .foregroundColor(.blue)
//                } else {
//                    Button(action: {
//                        // Define your action here
//                    }) {
//                        Text("+ Invite")
//                            .foregroundColor(.blue)
//                    }
//                }
//            }
//        }
//        .onAppear {
//            viewModel.requestAccess()
//        }
//    }
//}
//
