//
//  CoinDataService.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 24/10/2024.
//

import Foundation
import Combine

// swiftlint:disable line_length
extension AppURLs {
    static var coins: String {
        return base + "/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    }
}
// swiftlint:enable line_length

class CoinDataService {

    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    func getCoins() {
        guard let url = AppURLs.coins.url else { return }
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
