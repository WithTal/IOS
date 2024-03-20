//
//  Extensions.swift
//  TalIOS
//
//  Created by Pablo Hansen on 3/16/24.
//
import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
   
  override func configuration(shielding application: Application) -> ShieldConfiguration {
    // Customize the shield as needed for applications.
    return ShieldConfiguration(
      backgroundBlurStyle: UIBlurEffect.Style.systemThickMaterial,
      backgroundColor: UIColor.white,
      icon: UIImage(systemName: "stopwatch"),
      title: ShieldConfiguration.Label(text: "No app for you", color: .yellow),
      subtitle: ShieldConfiguration.Label(text: "Sorry, no apps for you", color: .white),
      primaryButtonLabel: ShieldConfiguration.Label(text: "Ask for a break?", color: .white),
      secondaryButtonLabel: ShieldConfiguration.Label(text: "Quick Quick", color: .white)
    )
  }
   
  override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
    // Customize the shield as needed for applications shielded because of their category.
    return ShieldConfiguration(
      backgroundBlurStyle: UIBlurEffect.Style.systemThickMaterial,
      backgroundColor: UIColor.white,
      icon: UIImage(systemName: "stopwatch"),
      title: ShieldConfiguration.Label(text: "No app for you", color: .yellow),
      subtitle: ShieldConfiguration.Label(text: "Sorry, no apps for you", color: .white),
      primaryButtonLabel: ShieldConfiguration.Label(text: "Ask for a break?", color: .white),
      secondaryButtonLabel: ShieldConfiguration.Label(text: "Quick Quick", color: .white)
    )
  }

  override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
    // Customize the shield as needed for web domains.
    return ShieldConfiguration(
      backgroundBlurStyle: UIBlurEffect.Style.systemThickMaterial,
      backgroundColor: UIColor.white,
      icon: UIImage(systemName: "stopwatch"),
      title: ShieldConfiguration.Label(text: "No app for you", color: .yellow),
      subtitle: ShieldConfiguration.Label(text: "Sorry, no apps for you", color: .white),
      primaryButtonLabel: ShieldConfiguration.Label(text: "Ask for a break?", color: .white),
      secondaryButtonLabel: ShieldConfiguration.Label(text: "Quick Quick", color: .white)
    )
  }

  override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
    // Customize the shield as needed for web domains shielded because of their category.
    return ShieldConfiguration(
      backgroundBlurStyle: UIBlurEffect.Style.systemThickMaterial,
      backgroundColor: UIColor.white,
      icon: UIImage(systemName: "stopwatch"),
      title: ShieldConfiguration.Label(text: "No app for you", color: .yellow),
      subtitle: ShieldConfiguration.Label(text: "Sorry, no apps for you", color: .white),
      primaryButtonLabel: ShieldConfiguration.Label(text: "Ask for a break?", color: .white),
      secondaryButtonLabel: ShieldConfiguration.Label(text: "Quick Quick", color: .white)
    )
  }
}

import ManagedSettings

// Assuming you have defined your ShieldConfigurationExtension as per your previous code
let shieldConfigExt = ShieldConfigurationExtension()

// Managed Settings Store

let storeName = ManagedSettingsStore.Name("Sample")
let store = ManagedSettingsStore(named: storeName)

// Bundle Identifiers for the apps
let redditBundleIdentifier = "com.example.reddit"
let instagramBundleIdentifier = "com.instagram.instagram"
let twitterBundleIdentifier = "com.example.twitter"

// Create an array of applications to shield
let appsToShield = [Application(bundleIdentifier: redditBundleIdentifier),
                    Application(bundleIdentifier: instagramBundleIdentifier),
                    Application(bundleIdentifier: twitterBundleIdentifier)]

func applyShields() {
    print("HI")
    // Initialize your custom shield configuration extension
    let shieldConfigExt = ShieldConfigurationExtension()

    // Create a Managed Settings Store
    let storeName = ManagedSettingsStore.Name("Sample")
    let store = ManagedSettingsStore(named: storeName)

    // Bundle Identifiers for the apps to shield
    let redditBundleIdentifier = "com.example.reddit"
    let instagramBundleIdentifier = "com.instagram.instagram"
    let twitterBundleIdentifier = "com.example.twitter"

//    // Create an array of applications to shield
//    let appsToShield = [Application(bundleIdentifier: redditBundleIdentifier),
//                        Application(bundleIdentifier: instagramBundleIdentifier),
//                        Application(bundleIdentifier: twitterBundleIdentifier)]
//    let appsToShieldTokens = appsToShield.map { ApplicationToken(application: $0) }
//
//    // Apply shield configuration to each app
//    for appToken in appsToShieldTokens {
//        let shieldConfig = shieldConfigExt.configuration(shielding: appToken.application)
//        // Apply the shield configuration to the store
//        store.shield.applications = [appToken]
//        store.shield.configuration = shieldConfig
//    }


    // Additional code to handle the actual shielding logic
}




