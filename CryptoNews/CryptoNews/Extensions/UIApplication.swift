//
//  UIApplication.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 28/10/2024.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
