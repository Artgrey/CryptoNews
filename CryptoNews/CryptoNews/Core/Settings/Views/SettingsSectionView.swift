//
//  SettingsSectionView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 08/11/2024.
//

import SwiftUI

extension Constants {
    struct SettingsSection {
        static let opacity = CGFloat(0.5)
        static let imageHeight = CGFloat(100)
        static let imageCornerRadius = CGFloat(20)
    }
}

struct SettingsSectionView: View {

    let info: SettingsSection

    var body: some View {
        Section(header: Text(info.header)) {
            mainContent
            linksContent
        }
        .font(.headline)
        .accentColor(.blue)
        .listRowBackground(Color.theme.background.opacity(Constants.SettingsSection.opacity))
    }
}

#Preview {
    List {
        SettingsSectionView(info: SettingsSection(header: "Developer",
                            image: Image.appImages.logo,
                            description: "Description",
                            links: [
                                SettingsSectionLink(
                                    url: AppURLs.google.url,
                                    title: "Google"
                                )
                            ])
        )
    }
}

extension SettingsSectionView {

    private var mainContent: some View {
        VStack(alignment: .leading, content: {
            info.image
                .resizable()
                .scaledToFit()
                .frame(height: Constants.SettingsSection.imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: Constants.SettingsSection.imageCornerRadius))
            Text(info.description)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(Color.theme.accent)
        })
        .padding(.vertical)
    }

    private var linksContent: some View {
        ForEach(info.links, id: \.self) { link in
            if let url = link.url {
                Link(link.title, destination: url)
            }
        }
    }
}
