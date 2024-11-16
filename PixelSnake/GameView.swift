//
//  GameView.swift
//  PixelSnake
//
//  Created by Chaher Machhour on 12/11/2024.
//

import SwiftUI

struct GameView: View {
    @State var gameModel = GameModel()
    @State var cellSize: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: geometry.safeAreaInsets.top)
                
                ZStack {
                    // Zone de jeu avec bordure
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                        .background(Color.black)
                        .padding(10) // Léger padding
                        .frame(
                            width: geometry.size.width - 20, // Taille basée sur l'écran avec padding
                            height: geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom - 20
                        )
                    
                    // Serpent
                    ForEach(gameModel.snake, id: \.self) { segment in
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: cellSize, height: cellSize)
                            .position(x: CGFloat(segment.x) * cellSize + cellSize / 2,
                                      y: CGFloat(segment.y) * cellSize + cellSize / 2)
                    }
                    
                    // Nourriture
                    if let food = gameModel.food {
                        Circle()
                            .fill(Color.red)
                            .frame(width: cellSize, height: cellSize)
                            .position(x: CGFloat(food.x) * cellSize + cellSize / 2,
                                      y: CGFloat(food.y) * cellSize + cellSize / 2)
                    }
                    
                    // Game Over
                    if gameModel.isGameOver {
                        VStack {
                            Text("Game Over")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            
                            Text("Score: \(gameModel.score)")
                                .font(.title2)
                                .foregroundColor(.yellow)
                            
                            Button(action: {
                                gameModel.startGame()
                            }) {
                                Text("Rejouer")
                                    .font(.title2)
                                    .padding()
                                    .background(Capsule().fill(Color.blue))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            if abs(gesture.translation.width) > abs(gesture.translation.height) {
                                gameModel.changeDirection(to: gesture.translation.width > 0 ? GameModel.Position(x: 1, y: 0) : GameModel.Position(x: -1, y: 0))
                            } else {
                                gameModel.changeDirection(to: gesture.translation.height > 0 ? GameModel.Position(x: 0, y: 1) : GameModel.Position(x: 0, y: -1))
                            }
                        }
                )
                .onAppear {
                    let safeWidth = geometry.size.width - 20 // Ajustement pour padding
                    let safeHeight = geometry.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom - 20

                    // Calcul de la taille des cellules
                    cellSize = min(safeWidth / CGFloat(gameModel.gridWidth), safeHeight / CGFloat(gameModel.gridHeight))
                    
                    // Ajustement des dimensions de la grille pour correspondre parfaitement à l'écran
                    gameModel.gridWidth = Int(safeWidth / cellSize)
                    gameModel.gridHeight = Int(safeHeight / cellSize)
                    
                    gameModel.startGame()

                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                        gameModel.move()
                    }
                }
                
                Spacer(minLength: geometry.safeAreaInsets.bottom)
            }
        }
        .background(Color.black)
    }
}

#Preview {
    GameView()
}
