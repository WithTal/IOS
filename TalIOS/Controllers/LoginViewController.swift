////
////  LoginViewController.swift
////  TalIOS
////
////  Created by Pablo Hansen on 3/7/24.
////
//
//import Foundation
//
//
//import UIKit
//import AuthenticationServices
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var loginProviderStackView: UIStackView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupProviderLoginView()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        performExistingAccountSetupFlows()
//    }
//
//    /// - Tag: add_appleid_button
//    func setupProviderLoginView() {
//        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
////        self.loginProviderStackView.addArrangedSubview(authorizationButton)
//    }
//
//    // - Tag: perform_appleid_password_request
//    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
//    func performExistingAccountSetupFlows() {
//        // Prepare requests for both Apple ID and password providers.
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
//                        ASAuthorizationPasswordProvider().createRequest()]
//
//        // Create an authorization controller with the given requests.
//        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//
//    /// - Tag: perform_appleid_request
//    @objc
//    func handleAuthorizationAppleIDButtonPress() {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//}
//
//extension LoginViewController: ASAuthorizationControllerDelegate {
//    /// - Tag: did_complete_authorization
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//
//            // Create an account in your system.
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//
//            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
//            self.saveUserInKeychain(userIdentifier)
//
//            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
//            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
//
//        case let passwordCredential as ASPasswordCredential:
//
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            // For the purpose of this demo app, show the password credential as an alert.
//            DispatchQueue.main.async {
//                self.showPasswordCredentialAlert(username: username, password: password)
//            }
//
//        default:
//            break
//        }
//    }
//
//    private func saveUserInKeychain(_ userIdentifier: String) {
//        do {
////            TODO/
////            print("TODO Save keychain iem")
//            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
//        } catch {
//            print("Unable to save userIdentifier to keychain.")
//        }
//    }
//
//    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
//        guard let viewController = self.presentingViewController as? ResultViewController
//            else { return }
//
//        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    private func showPasswordCredentialAlert(username: String, password: String) {
//        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
//        let alertController = UIAlertController(title: "Keychain Credential Received",
//                                                message: message,
//                                                preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    /// - Tag: did_complete_error
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        // Handle error.
//    }
////    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
////        switch authorization.credential {
////        case let appleIDCredential as ASAuthorizationAppleIDCredential:
////
////            // Create an account in your system.
////            let userIdentifier = appleIDCredential.user
////            let fullName = appleIDCredential.fullName
////            let email = appleIDCredential.email
////
////            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
////            self.saveUserInKeychain(userIdentifier)
////
////            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
////            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
////
////        case let passwordCredential as ASPasswordCredential:
////
////            // Sign in using an existing iCloud Keychain credential.
////            let username = passwordCredential.user
////            let password = passwordCredential.password
////
////            // For the purpose of this demo app, show the password credential as an alert.
////            DispatchQueue.main.async {
////                self.showPasswordCredentialAlert(username: username, password: password)
////            }
////
////        default:
////            break
////        }
////    }
//
//}
//
//extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
//    /// - Tag: provide_presentation_anchor
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}
//
//extension UIViewController {
//
//    func showLoginViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
//            loginViewController.modalPresentationStyle = .formSheet
//            loginViewController.isModalInPresentation = true
//            self.present(loginViewController, animated: true, completion: nil)
//        }
//    }
//}
//
//
//
//import UIKit
//import AuthenticationServices
//
//class ResultViewController: UIViewController {
//
//    @IBOutlet weak var userIdentifierLabel: UILabel!
//    @IBOutlet weak var givenNameLabel: UILabel!
//    @IBOutlet weak var familyNameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var signOutButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        userIdentifierLabel.text = KeychainItem.currentUserIdentifier
//    }
//
//    @IBAction func signOutButtonPressed() {
//        // For the purpose of this demo app, delete the user identifier that was previously stored in the keychain.
//        KeychainItem.deleteUserIdentifierFromKeychain()
//
//        // Clear the user interface.
//        userIdentifierLabel.text = ""
//        givenNameLabel.text = ""
//        familyNameLabel.text = ""
//        emailLabel.text = ""
//
//        // Display the login controller again.
//        DispatchQueue.main.async {
//            self.showLoginViewController()
//        }
//    }
//}
//
//
//struct KeychainItem {
//    // MARK: Types
//
//    enum KeychainError: Error {
//        case noPassword
//        case unexpectedPasswordData
//        case unexpectedItemData
//        case unhandledError
//    }
//
//    // MARK: Properties
//
//    let service: String
//
//    private(set) var account: String
//
//    let accessGroup: String?
//
//    // MARK: Intialization
//
//    init(service: String, account: String, accessGroup: String? = nil) {
//        self.service = service
//        self.account = account
//        self.accessGroup = accessGroup
//    }
//
//    // MARK: Keychain access
//
//    func readItem() throws -> String {
//        /*
//         Build a query to find the item that matches the service, account and
//         access group.
//         */
//        var query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//        query[kSecMatchLimit as String] = kSecMatchLimitOne
//        query[kSecReturnAttributes as String] = kCFBooleanTrue
//        query[kSecReturnData as String] = kCFBooleanTrue
//
//        // Try to fetch the existing keychain item that matches the query.
//        var queryResult: AnyObject?
//        let status = withUnsafeMutablePointer(to: &queryResult) {
//            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
//        }
//
//        // Check the return status and throw an error if appropriate.
//        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
//        guard status == noErr else { throw KeychainError.unhandledError }
//
//        // Parse the password string from the query result.
//        guard let existingItem = queryResult as? [String: AnyObject],
//            let passwordData = existingItem[kSecValueData as String] as? Data,
//            let password = String(data: passwordData, encoding: String.Encoding.utf8)
//            else {
//                throw KeychainError.unexpectedPasswordData
//        }
//
//        return password
//    }
//
//    func saveItem(_ password: String) throws {
//        // Encode the password into an Data object.
//        let encodedPassword = password.data(using: String.Encoding.utf8)!
//
//        do {
//            // Check for an existing item in the keychain.
//            try _ = readItem()
//
//            // Update the existing item with the new password.
//            var attributesToUpdate = [String: AnyObject]()
//            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
//
//            let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
//
//            // Throw an error if an unexpected status was returned.
//            guard status == noErr else { throw KeychainError.unhandledError }
//        } catch KeychainError.noPassword {
//            /*
//             No password was found in the keychain. Create a dictionary to save
//             as a new keychain item.
//             */
//            var newItem = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//            newItem[kSecValueData as String] = encodedPassword as AnyObject?
//
//            // Add a the new item to the keychain.
//            let status = SecItemAdd(newItem as CFDictionary, nil)
//
//            // Throw an error if an unexpected status was returned.
//            guard status == noErr else { throw KeychainError.unhandledError }
//        }
//    }
//
//    func deleteItem() throws {
//        // Delete the existing item from the keychain.
//        let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//        let status = SecItemDelete(query as CFDictionary)
//
//        // Throw an error if an unexpected status was returned.
//        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError }
//    }
//
//    // MARK: Convenience
//
//    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
//        var query = [String: AnyObject]()
//        query[kSecClass as String] = kSecClassGenericPassword
//        query[kSecAttrService as String] = service as AnyObject?
//
//        if let account = account {
//            query[kSecAttrAccount as String] = account as AnyObject?
//        }
//
//        if let accessGroup = accessGroup {
//            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
//        }
//
//        return query
//    }
//
//    /*
//     For the purpose of this demo app, the user identifier will be stored in the device keychain.
//     You should store the user identifier in your account management system.
//     */
//    static var currentUserIdentifier: String {
//        do {
//            let storedIdentifier = try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").readItem()
//            return storedIdentifier
//        } catch {
//            return ""
//        }
//    }
//
//    static func deleteUserIdentifierFromKeychain() {
//        do {
//            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").deleteItem()
//        } catch {
//            print("Unable to delete userIdentifier from keychain")
//        }
//    }
//}
