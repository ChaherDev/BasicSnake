//
//  GameModel.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 12/11/2024.
//

import SwiftUI

@Observable
class GameModel {
    struct Position: Hashable {
        var x: Int
        var y: Int
    }
    
    var snake: [Position] = [Position(x: 5, y: 5)]
    var direction: Position = Position(x: 1, y: 0)
    var food: Position = Position(x: 3, y: 3)
    var score: Int = 0
    let gridSize: Int = 10
    var isGameOver: Bool = false  // État de fin de partie

    func move() {
        guard !isGameOver else { return }  // Ne pas bouger si le jeu est terminé

        var head = snake.first!
        head.x += direction.x
        head.y += direction.y
        
        // Vérifier si le serpent touche un côté
        if head.x < 0 || head.x >= gridSize || head.y < 0 || head.y >= gridSize {
            isGameOver = true  // Fin de partie
            return
        }
        
        if head == food {
            score += 1
            food = Position(x: Int.random(in: 0..<gridSize), y: Int.random(in: 0..<gridSize))
        } else {
            snake.removeLast()
        }
        
        snake.insert(head, at: 0)
    }
    
    func changeDirection(to newDirection: Position) {
        if (newDirection.x != -direction.x || newDirection.y != -direction.y) {
            direction = newDirection
        }
    }
    
    func resetGame() {
        snake = [Position(x: 5, y: 5)]
        direction = Position(x: 1, y: 0)
        score = 0
        food = Position(x: 3, y: 3)
        isGameOver = false  // Réinitialiser l'état de fin de partie
    }
}
