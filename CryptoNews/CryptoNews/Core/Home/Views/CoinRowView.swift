//
//  CoinRowView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 23/10/2024.
//

import SwiftUI

struct CoinRowView: View {

    let coin: CoinModel
    let showHoldingsColumn: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
               centerColumn
            }
           rightColumn
        }
        .font(.subheadline)
        .background(Color.theme.background.opacity(0.001))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)

        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
            .colorScheme(.dark)
    }
}

extension CoinRowView {

    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)

            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }

    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }

    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H.asPercentString())
                .foregroundStyle(
                    coin.priceChangePercentage24H >= 0 ?
                        Color.theme.high : Color.theme.low
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
