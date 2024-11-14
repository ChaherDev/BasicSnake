//
//  GameView.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 12/11/2024.
//

// GameView.swift

import SwiftUI
import UIKit

// Vue principale du jeu
struct GameView: View {
    @State private var score = 0
    @State private var direction: Direction = .right
    @State private var snake = [CGPoint(x: 10, y: 10)]
    @State private var gameOver = false

    var body: some View {
        ZStack {
            // Contexte de jeu avec un fond
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // Affichage du score
            Text("\(score)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 50)

            // Représentation du serpent
            ForEach(snake, id: \.self) { segment in
                Rectangle()
                    .frame(width: 20, height: 20)
                    .position(x: segment.x * 20, y: segment.y * 20)
                    .foregroundColor(.green)
            }

            // Affichage de Game Over
            if gameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
        .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let horizontal = value.translation.width
                        let vertical = value.translation.height
                        if abs(horizontal) > abs(vertical) {
                            if horizontal > 0 {
                                direction = .right
                            } else {
                                direction = .left
                            }
                        } else {
                            if vertical > 0 {
                                direction = .down
                            } else {
                                direction = .up
                            }
                        }
                    })
        // Gérer les événements de clavier (sur macOS et iOS)
        .background(KeyboardEventsView { direction in
            self.direction = direction
        })
        .onAppear {
            startGame()
        }
    }

    // Fonction pour démarrer une nouvelle partie
    func startGame() {
        snake = [CGPoint(x: 10, y: 10)] // Position de départ du serpent
        score = 0
        gameOver = false
        moveSnake()
    }

    // Fonction pour faire avancer le serpent
    func moveSnake() {
        guard !gameOver else { return }

        // Logique de mouvement du serpent
        var head = snake.first!
        switch direction {
        case .up:
            head.y -= 1
        case .down:
            head.y += 1
        case .left:
            head.x -= 1
        case .right:
            head.x += 1
        }

        // Vérifier si le serpent se heurte à lui-même ou aux bords
        if snake.contains(where: { $0 == head }) || head.x < 0 || head.y < 0 || head.x >= 20 || head.y >= 20 {
            gameOver = true
        } else {
            // Ajouter un nouveau segment à la tête du serpent
            snake.insert(head, at: 0)
            snake.removeLast()

            // Mettre à jour le score
            score += 1
        }

        // Réessayer après une courte pause
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            moveSnake()
        }
    }
}

// Direction du serpent
enum Direction {
    case up, down, left, right
}

// Vue représentant les événements du clavier
struct KeyboardEventsView: UIViewControllerRepresentable {
    var onArrowKeyPressed: (Direction) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = KeyboardEventsViewController()
        viewController.onArrowKeyPressed = onArrowKeyPressed
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Rien à faire ici pour ce cas spécifique
    }
}

class KeyboardEventsViewController: UIViewController {
    var onArrowKeyPressed: ((Direction) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ajout des commandes de touches pour iOS/macOS
        let upKey = UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(handleArrowKey(_:)))
        let downKey = UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(handleArrowKey(_:)))
        let leftKey = UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(handleArrowKey(_:)))
        let rightKey = UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(handleArrowKey(_:)))

        addKeyCommand(upKey)
        addKeyCommand(downKey)
        addKeyCommand(leftKey)
        addKeyCommand(rightKey)
    }

    @objc func handleArrowKey(_ sender: UIKeyCommand) {
        switch sender.input {
        case UIKeyCommand.inputUpArrow:
            onArrowKeyPressed?(.up)
        case UIKeyCommand.inputDownArrow:
            onArrowKeyPressed?(.down)
        case UIKeyCommand.inputLeftArrow:
            onArrowKeyPressed?(.left)
        case UIKeyCommand.inputRightArrow:
            onArrowKeyPressed?(.right)
        default:
            break
        }
    }
}


#Preview {
    GameView()
}
