//
//  HomeLayout.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/10/24.
//

import Foundation
//
//  OnboardingLayout.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/7/24.
//

import Foundation

import SwiftUI

struct ReusableHomeView2<Content: View>: View {
    let topText: String
    let subTopText: String
    @State private var selectedTab = 0
    @State private var isToggleShown = false // State to control the visibility of the toggle

    let skippable: Bool
    var buttonText: String?
    var buttonAction: () -> Void
    var logo: Bool?
    var alignLeft: Bool?
    @Binding var currentScreen: HomeScreen
    
    
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack {
            // Header with logo and skip button
            HStack {
                Image(systemName: "t.circle.fill") // Placeholder for the logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30) // Adjust the size as needed
                    .foregroundColor(.white)

                Spacer() // Pushes the logo to the left and the skip button to the right

                if skippable {
                    SkipButton() // A simple button with an action
                }
            }
            .padding([.top, .leading, .trailing])

            // Text and Subtext
            Text(topText)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.top, 20)

            Text(subTopText)
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            content // Placeholder for additional content

            Spacer()

            // Toggle View
            if isToggleShown {
                Toggle(isOn: $isToggleShown) {
                    Text("Schedule for later")
                        .foregroundColor(isToggleShown ? .white : .gray)
                }
                .padding()
            }

            // Action Button
            if let text = buttonText {
                ActionButton(text: text, action: {
                    // Action for the button
                    isToggleShown.toggle() // Show or hide the toggle when button is pressed
                    buttonAction()
                })
                .padding(.bottom, 20)
            }

            // Bottom Navigation Tabs
//            BottomNavigationTabs(currentScreen: $currentScreen , selectedTab: $selectedTab)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
        .padding(.horizontal, 20)
    }
}

// Define a reusable view that has placeholders for top, sub-top, content, and a bottom button.
struct ReusableHomeView<Content: View>: View {
    let screenIdx: Int

    @Binding var currentScreen: HomeScreen
    let topText: String
    let subTopText: String
    @State private var selectedTab = 0  // Default to the first tab
    @State private var showSheet = false
    
    
    
    let skippable: Bool
    var buttonText: String?
    

//    var buttonAction: () -> Void // Closure type for button action
    var logo: Bool?
    var alignLeft: Bool?
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image("T") // Replace "T" with your actual image asset name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100) // Adjust the size as needed
//                        .padding(.leading) // Add padding to align the image inside the HStack

                    Spacer() // This pushes the image and the button to opposite ends

//                    if skippable {
                        SkipButton()
                            .padding(.trailing) // Add padding to align the button inside the HStack
//                    }
                }

                Spacer()

                if let buttonText = buttonText {
                    Button(buttonText) {
                        showSheet.toggle() // Modify this action as needed
                    }
                    .sheet(isPresented: $showSheet) {
                        NewBlockView()
                        // Your sheet content here
                       
                    }
                    // Style your button here
                }
                // Main action button
//                if let text = buttonText {
//                    ActionButton(text: text, action: buttonAction).fontWeight(.bold)
//                }

                // Bottom Navigation Tabs
                BottomNavigationTabs(selectedTab: screenIdx, currentScreen: $currentScreen)
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
        }
    }

}


// Skip Button View
struct SkipButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Skip")
                .padding([.leading])
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4)) // #666666
        }
    }
}

// Logo View
struct LogoView: View {
    let geometry: GeometryProxy

    var body: some View {
        HStack {
            Image("Logo") // Replace "Logo" with your actual logo image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width / 2)
                .padding()
        }
    }
}

// Top Text View
struct TopTextView: View {
    let topText: String
    let subTopText: String
    var alignLeft: Bool?

    var body: some View {
        VStack(alignment: alignLeft == true ? .leading : .center) {
            Text(topText)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 10)
                .foregroundColor(.white)

            Text(subTopText)
                .font(.headline)
                .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8)) // #cccccc
                .padding(.bottom, 20)
        }
    }
}

// Action Button View
struct ActionButton: View {
    let text: String
    let action: () -> Void
    

    var body: some View {
        Button(text, action: action)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(25)
            .padding(.horizontal, 32)
            .padding(.bottom, 20)
    }
}

struct BottomNavigationTabs: View {
    let selectedTab: Int
    @Binding var currentScreen: HomeScreen
//    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Button(action: {
//                selectedTab = 0
                currentScreen = .home
            }) {
                VStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(selectedTab == 0 ? .white : .gray)
                        .font(.system(size: 25))
                    Text("Home")
                        .foregroundColor(selectedTab == 0 ? .white : .gray)
                }
            }

            Spacer()

            Button(action: {
//                selectedTab = 1
                currentScreen = .blocks
            }) {
                VStack {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(selectedTab == 1 ? .white : .gray)
                        .font(.system(size: 25))
                    Text("Stats")
                        .foregroundColor(selectedTab == 1 ? .white : .gray)
                }
            }

            Spacer()

            Button(action: {
//                selectedTab = 2
                currentScreen = .profile
            }) {
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(selectedTab == 2 ? .white : .gray)
                        .font(.system(size: 25))
                    Text("Profile")
                        .foregroundColor(selectedTab == 2 ? .white : .gray)
                }
            }
        }
        .padding()
        .cornerRadius(25)
    }
}


enum HomeScreen {
    case home
    case blocks
    case profile
//    case

}

struct HomeView: View {
    @State private var currentScreen: HomeScreen = .home
    @Binding var showOnboarding: Bool


    var body: some View {
            VStack {
                switch currentScreen {
                    
                case .home:
                    HomeView
                case .blocks:
                    BlocksView
                case .profile:
                    ProfileView
                }
            }
        }

      

    var HomeView: some View {
        ReusableHomeView(
        
            screenIdx: 0,
            currentScreen: $currentScreen,
            
            topText: "Add your friends to see their screen time",
            subTopText: "You thought your screen time was bad?",
            skippable: false,
            buttonText: "New Block",
            //               buttonAction: {
            //                   print("Contacts -> Add Friends button pressed")
            //                   currentScreen = .secrets
            //               },
            alignLeft: true
        ){
            // Placeholder for [Graphic of friends]
            Text("[Graphic of friends Content]")
        }
       }
    var BlocksView: some View {
        ReusableHomeView(
            screenIdx: 1,
            currentScreen: $currentScreen,
            topText: "Add your friends to see their screen time",
            subTopText: "You thought your screen time was bad?", skippable: false,
            buttonText: "Blocks",
            //               buttonAction: {
            //                   print("Contacts -> Add Friends button pressed")
            //                   currentScreen = .secrets
            //               },
            alignLeft: true
        ){
            // Placeholder for [Graphic of friends]
            Text("[Graphic of friends Content]")
        }
       }

    var ProfileView: some View {
        ReusableHomeView(
            screenIdx: 2,

            currentScreen: $currentScreen,
            topText: "Add your friends to see their screen time",
            subTopText: "Profile your screen time was bad?", skippable: false,
            buttonText: "New Block",
            //               buttonAction: {
            //                   print("Contacts -> Add Friends button pressed")
            //                   currentScreen = .secrets
            //               },
            alignLeft: true
        ){
            // Placeholder for [Graphic of friends]
            Text("[Graphic of friends Content]")
        }
       }


    // Add other views for different screens
}

