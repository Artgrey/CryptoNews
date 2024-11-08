//
//  MarketDataService.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 28/10/2024.
//

import Foundation
import Combine

extension AppURLs {
    static var market: String {
        return base + "/global"
    }
}

class MarketDataService {

    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    func getData() {
        guard let url = AppURLs.market.url else { return }
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
