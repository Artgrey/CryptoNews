//
//  DetailViewModel.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 03/11/2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    @Published var overiviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overiviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)

        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }

    private func mapDataToStatistics(details: CoinDetailModel?,
                                     coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        // overview
        let overviewArray: [StatisticModel] = createOverviewArray(coin: coin)

        // additional
        let additionalArray: [StatisticModel] = createAdditionalOverview(details: details, coin: coin)

        return (overviewArray, additionalArray)
    }

    func createOverviewArray(coin: CoinModel) -> [StatisticModel] {
        // overview
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)

        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization",
                                           value: marketCap,
                                           percentageChange: marketCapPercentChange)

        let rank = "\(coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)

        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)

        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }

    func createAdditionalOverview(details: CoinDetailModel?, coin: CoinModel) -> [StatisticModel] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)

        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)

        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change",
                                             value: priceChange,
                                             percentageChange: pricePercentChange2)

        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change",
                                                 value: marketCapChange,
                                                 percentageChange: marketCapPercentChange2)

        let blockTime = details?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)

        let hashing = details?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)

        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return additionalArray
    }
}
