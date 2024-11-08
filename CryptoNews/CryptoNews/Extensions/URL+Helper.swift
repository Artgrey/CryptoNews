//
//  URL+Helper.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 07/11/2024.
//

import Foundation

extension String {
    var url: URL? {
        URL(string: self)
    }
}
