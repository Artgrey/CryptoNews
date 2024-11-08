//
//  String.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 03/11/2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
