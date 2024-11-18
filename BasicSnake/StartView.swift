//
//  StartView.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 13/11/2024.
//

import SwiftUI

struct StartView: View {
    @Binding var isGameStarted: Bool  // Pour basculer vers l'écran de jeu
    
    var body: some View {
        VStack {
            Button(action: {
                isGameStarted = true  // Lancer le jeu
            }) {
                Label("Start", systemImage: "play.circle.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.green))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    StartView(isGameStarted: .constant(false))
}
