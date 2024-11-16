//
//  PixelSnakeApp.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 12/11/2024.
//

import SwiftUI

@main
struct PixelSnakeApp: App {
    @State private var isGameStarted = false  // Contrôle si le jeu a démarré
    
    var body: some Scene {
        WindowGroup {
            if isGameStarted {
                GameView()  // Affiche le jeu lorsque le jeu est démarré
            } else {
                StartView(isGameStarted: $isGameStarted)  // Affiche l'écran d'accueil
            }
        }
    }
}
