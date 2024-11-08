//
//  CoinImageView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 24/10/2024.
//

import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel

    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .padding()
        .previewLayout(.sizeThatFits)
}
