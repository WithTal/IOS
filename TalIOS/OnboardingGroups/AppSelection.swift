//
//  AppSelection.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/12/24.
//

import Foundation
import SwiftUI

import FamilyControls

//var initialApps2View: some View {
//
//    // Since the prompt states NA, you may not need an action or button here, assuming this is a transitional view
////    Text("The swift selection interface Content")
////        .onAppear {
////            // Auto-navigate after some task is done, if needed
//////                   DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//////                       print("Initial Apps 2 -> Auto-navigate")
//////                       currentScreen = .initialApps3
//////                   }
////        }
//}




    
struct initialApps2View: View {
    @State var selection = FamilyActivitySelection()

    @Binding var currentScreen: AppScreen

 
       
            
            
            
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    currentScreen = .explanationOfBlocks
//                    print("Button pressed")
                } label: {
                    Text("Next").padding([.leading])
                                .foregroundColor(.blue)
                }

                
                
              // #666666)
            }
            
//            Image(systemName: "eye")
//                .font(.system(size: 76.0))
//                .padding()

            FamilyActivityPicker(selection: $selection)


//            Image(systemName: "hourglass")
//                .font(.system(size: 76.0))
//                .padding()
        }
        .edgesIgnoringSafeArea(.all) // Make the background ignore the safe area to extend to the edges
        .foregroundColor(.white) // Set the default text color to white inside the VStack
        .padding(.vertical, 20) // This adds vertical padding to the top and bottom inside the VStack
        .padding(.horizontal, 20)

        .onChange(of: selection) { newSelection in
            let applications = selection.applications
            let categories = selection.categories
            let webDomains = selection.webDomains
        }
    }
}

