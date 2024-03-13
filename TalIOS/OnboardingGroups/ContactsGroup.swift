//
//  ContactsGroup.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/10/24.
//


import Contacts
import SwiftUI

struct Contact: Identifiable {
    let id: String
    let name: String
    let detail: String
    let imageData: Data?
    let isFriend: Bool
    var isSelected: Bool = false
}



class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []

    private let store = CNContactStore()

    func requestAccess() {
        store.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to request access", error)
                    return
                }
                if granted {
                    self.loadContacts()
                } else {
                    print("Access denied")
                }
            }
        }
    }

    func toggleContactSelection(contactId: String) {
        if let index = contacts.firstIndex(where: { $0.id == contactId }) {
            contacts[index].isSelected.toggle()
        }
    }

    func loadContacts() {
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataKey // Include this key to fetch profile images
        ] as [CNKeyDescriptor]

        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        do {
            try store.enumerateContacts(with: request) { (cnContact, stop) in
                // Assume everyone is not a friend for the example
                let contact = Contact(
                    id: cnContact.identifier,
                    name: "\(cnContact.givenName) \(cnContact.familyName)",
                    detail: (cnContact.phoneNumbers.first?.value.stringValue) ?? "",
                    imageData: cnContact.imageData, // Store the image data
                    isFriend: false
                )
                DispatchQueue.main.async { // Ensure you update the UI on the main thread
                    self.contacts.append(contact)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                print("Failed to fetch contact, error: \(error)")
            }
        }
    }
}


struct ContactsPreview: View {
    @Binding var currentScreen: AppScreen
    
    var body: some View {
        ReusablePageView(
            topText: "Add your friends to see their screen time",
            subTopText: "You thought your screen time was bad?", skippable: false,
            buttonText: "Add Contacts",
            buttonAction: {
                print("Contacts -> Add Friends button pressed")
                currentScreen = .contacts2
            },
            alignLeft: true
        ) {
            // Placeholder for [Graphic of friends]
            Text("[Graphic of friends Content]")
        }
    }
}




struct ContactsView: View {
    @ObservedObject var viewModel = ContactsViewModel()
    @State private var searchText = ""
    @Binding var currentScreen: AppScreen

    var filteredContacts: [Contact] {
        let sortedContacts = viewModel.contacts.sorted {
            switch ($0.imageData != nil, $1.imageData != nil) {
            case (true, false):
                return true
            case (false, true):
                return false
            case (_, _):
                return $0.name < $1.name
            }
        }

        if searchText.isEmpty {
            return sortedContacts
        } else {
            return sortedContacts.filter { contact in
                contact.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
//    var filteredContacts: [Contact] {
//        if searchText.isEmpty {
//            return viewModel.contacts
//        } else {
//            return viewModel.contacts.filter { contact in
//                contact.name.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    Button("Next", action: {
                        print("Contacts -> Add Friends button pressed")
                        currentScreen = .secrets
                    })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20)
                    // spacing can be adjusted to create gaps
                    ForEach(filteredContacts) { contact in
                        
//                        if (contact.name!==""){
                            HStack {
                                if let imageData = contact.imageData, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } else {
                                    
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.gray)
                                    
                                }
                                VStack(alignment: .leading) {
                                    Text(contact.name)
                                        .font(.title3)
                                    //                                Text(contact.detail)
                                    
                                    Text("IN YOUR CONTACTS")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.639, green: 0.639, blue: 0.639)) // #a3a3a3
                                    //                                    .padding(.top, .03)
                                }
                                Spacer()
                                if contact.isFriend {
                                    Text("Friends")
                                        .foregroundColor(.blue)
                                } else {
                                    Button(action: {
                                        viewModel.toggleContactSelection(contactId: contact.id)
                                    }) {
                                        Image(systemName: contact.isSelected ? "checkmark.circle.fill" : "plus.circle")
                                            .foregroundColor(contact.isSelected ? .green : .blue)
                                    }
                                }
                            }
                            .padding()  // Add padding around the content
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(red: 0.098, green: 0.098, blue: 0.098)) // #191919// Set the background color of the padded area to black
                            .cornerRadius(10)  // Optional corner radius for a card-like effect
                        }
//                    }
                }
                .padding(.vertical)  // Add padding at the top and bottom of the ScrollView
            }
            .padding(.horizontal, 20)
            .background(Color.black)  // Set the ScrollView background color to black
            .searchable(text: $searchText)
            .navigationTitle("Contacts")
            .onAppear {
                viewModel.requestAccess()
            }
        }
    }
}
