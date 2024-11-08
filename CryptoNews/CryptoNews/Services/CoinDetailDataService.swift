//
//  CoinDetailDataService.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 03/11/2024.
//

import Foundation
import Combine

// swiftlint:disable line_length
extension AppURLs {
    static func details(id: String) -> String {
        return base + "/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    }
}
// swiftlint:enable line_length

class CoinDetailDataService {

    @Published var coinDetails: CoinDetailModel?
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }

    func getCoinDetails() {
        guard let url = AppURLs.details(id: coin.id).url else { return }
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: {[weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
