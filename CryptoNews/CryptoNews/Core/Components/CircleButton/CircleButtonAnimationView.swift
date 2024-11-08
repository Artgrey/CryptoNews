//
//  CircleButtonAnimationView.swift
//  CryptoNews
//
//  Created by Arturas Krivenkis on 23/10/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {

    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none, value: 1)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundStyle(Color.red)
        .frame(width: 50, height: 50)
}
