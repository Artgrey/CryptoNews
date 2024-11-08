//
//  String+Image.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 08/11/2024.
//

import SwiftUI

extension String {
    var systemImage: Image {
        return Image(systemName: self)
    }

    var image: Image {
        return Image(self)
    }
}
