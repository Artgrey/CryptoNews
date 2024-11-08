//
//  HapticManager.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 03/11/2024.
//

import Foundation
import SwiftUI

class HapticManager {

    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
