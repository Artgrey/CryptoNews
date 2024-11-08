//
//  SettingsViewModel.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 08/11/2024.
//

import Foundation
import SwiftUI

class SettingsViewModel {
    let defaultURL = AppURLs.github.url

    let swiftfulThinkingSection = SettingsSection(
        header: AppStrings.swiftfulThinking,
        image: Image.appImages.logo,
        description: AppStrings.swiftfulThinkingDesc,
        links: [SettingsSectionLink(url: AppURLs.youtube.url,
                                    title: AppStrings.swiftfullThinkingTitle)]
    )

    let coinGeckoSection = SettingsSection(
        header: AppStrings.coinGecko,
        image: Image.appImages.coindecko,
        description: AppStrings.coinGeckoDesc,
        links: [SettingsSectionLink(url: AppURLs.coindecko.url,
                                    title: AppStrings.coinGeckoTitle)]
    )

    let developerSection = SettingsSection(
        header: AppStrings.developer,
        image: Image.appImages.portfolio,
        description: AppStrings.developerDesc,
        links: [
            SettingsSectionLink(url: AppURLs.linkedIn.url,
                                title: AppStrings.LinkedInTitle),
            SettingsSectionLink(url: AppURLs.github.url,
                                title: AppStrings.githubTitle)
        ]
    )
}
