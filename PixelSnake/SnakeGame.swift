//
//  SnakeGame.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 12/11/2024.
//

import Foundation

@Observable
class SnakeGame {
    var snake: [(x: Int, y: Int)] = [(5, 5)]  // Position initiale du serpent
    var direction: (x: Int, y: Int) = (1, 0)  // Direction initiale : droite
    var food: (x: Int, y: Int) = (3, 3)  // Position initiale de la nourriture
    var score: Int = 0  // Score du joueur
    
    // Fonction pour déplacer le serpent
    func move() {
        var head = snake.first!
        head.x += direction.x
        head.y += direction.y
        
        // Vérifier si le serpent mange la nourriture
        if head == food {
            score += 1  // Incrémenter le score
            food = (x: Int.random(in: 0...10), y: Int.random(in: 0...10))  // Générer une nouvelle nourriture
        } else {
            snake.removeLast()  // Retirer la queue du serpent
        }
        
        snake.insert(head, at: 0)  // Ajouter la nouvelle tête du serpent
    }
    
    // Fonction pour changer la direction du serpent
    func changeDirection(to newDirection: (x: Int, y: Int)) {
        // On empêche le serpent de se retourner sur lui-même
        if (newDirection.x != -direction.x || newDirection.y != -direction.y) {
            direction = newDirection
        }
    }
    
    // Fonction pour réinitialiser le jeu
    func resetGame() {
        snake = [(5, 5)]  // Réinitialiser la position du serpent
        direction = (1, 0)  // Réinitialiser la direction
        score = 0  // Réinitialiser le score
        food = (3, 3)  // Réinitialiser la position de la nourriture
    }
}
