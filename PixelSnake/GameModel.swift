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
    
    var snake: [Position] = [Position(x: 10, y: 10)]
    var direction: Position = Position(x: 1, y: 0)
    var food: Position?
    var score: Int = 0
    var gridWidth: Int = 30 // Augmenté pour rendre la grille plus grande
    var gridHeight: Int = 30 // Augmenté pour rendre la grille plus grande
    var isGameOver = false
    
    func startGame() {
        resetGame()
        isGameOver = false
        generateFood()
    }
    
    func move() {
        guard !isGameOver else { return }
        
        var head = snake.first!
        head.x += direction.x
        head.y += direction.y
        
        // Vérification des limites du jeu
        if head.x < 2 || head.x >= gridWidth || head.y < 2 || head.y >= gridHeight || snake.contains(head) {
            isGameOver = true
            return
        }
        
        if head == food {
            score += 1
            generateFood()
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
        snake = [Position(x: gridWidth / 2, y: gridHeight / 2)]
        direction = Position(x: 1, y: 0)
        score = 0
        isGameOver = false
        generateFood()
    }
    
    private func generateFood() {
        let minX = 1 // Position minimale à l'intérieur de la zone de jeu
        let minY = 1 // Position minimale à l'intérieur de la zone de jeu
        let maxX = gridWidth - 2 // Position maximale pour éviter la bordure droite
        let maxY = gridHeight - 2 // Position maximale pour éviter la bordure basse
        
        repeat {
            food = Position(x: Int.random(in: minX...maxX), y: Int.random(in: minY...maxY))
        } while snake.contains(food!)
    }

}
