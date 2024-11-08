//
//  Image.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 07/11/2024.
//

import Foundation
import SwiftUI

extension Image {
    static let appImages = AppImages()
    static let systemImages = SystemImages()
}

struct AppImages {
    let logoClear = Image("logo-transparent")
    let coindecko = Image("coingecko")
    let logo = Image("logo")
    let portfolio = Image("portfolio")
}

struct SystemImages {
    let checkmark = "checkmark".systemImage
}
