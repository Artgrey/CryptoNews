//
//  CryptoNewsApp.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 22/10/2024.
//

import SwiftUI

@main
struct CryptoNewsApp: App {

    @StateObject private var viewModel = HomeViewModel()
    @State private var showLaunchView: Bool = true

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor: UIColor(Color.theme.accent) ]
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor: UIColor(Color.theme.accent) ]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = UIColor.clear
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .navigationViewStyle(.stack)
                .environmentObject(viewModel)

                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
