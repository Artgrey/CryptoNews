//
//  SettingsView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 06/11/2024.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) private var dismiss
    private let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()

                List {
                    swiftfulThinkingSection
                    coinGeckoSection
                    developerSection
                    applicationSection
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle(AppStrings.settings)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {

    private var swiftfulThinkingSection: some View {
        SettingsSectionView(info: viewModel.swiftfulThinkingSection)
    }

    private var coinGeckoSection: some View {
        SettingsSectionView(info: viewModel.coinGeckoSection)
    }

    private var developerSection: some View {
        SettingsSectionView(info: viewModel.developerSection)
    }

    private var applicationSection: some View {
        Section(header: Text(AppStrings.application)) {
            if let url = viewModel.defaultURL {
                Link(AppStrings.terms, destination: url)
                Link(AppStrings.privacy, destination: url)
                Link(AppStrings.company, destination: url)
                Link(AppStrings.learnMore, destination: url)
            }
        }
        .listRowBackground(Color.theme.background.opacity(Constants.SettingsSection.opacity))
    }
}
