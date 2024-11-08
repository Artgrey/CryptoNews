//
//  CoinLogoView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 02/11/2024.
//

import SwiftUI

struct CoinLogoView: View {

    let coin: CoinModel

    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CoinLogoView(coin: DeveloperPreview.instance.coin)
            .colorScheme(.dark)

        CoinLogoView(coin: DeveloperPreview.instance.coin)
    }
}
