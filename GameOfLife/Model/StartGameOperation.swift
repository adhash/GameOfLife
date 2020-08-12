//
//  StartGameOperation.swift
//  GameOfLife
//
//  Created by wojtek on 12/08/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import Foundation
import UIKit

class StartGameOperation : Operation {
    
    private let numberOfIterations: Int
    private let gameBoardController: GameBoardController
    
    init(noOfIterations: Int, gameBoardController: GameBoardController) {
        self.numberOfIterations = noOfIterations
        self.gameBoardController = gameBoardController
    }
    
    override func main() {
        let width = Int(exactly: self.gameBoardController.view.frame.size.width)
        let height = Int(exactly: self.gameBoardController.view.frame.size.height)
        let gameBoard = GameBoard(width: width! / Cell.width, height: height! / Cell.height, rules: self.gameBoardController.gameRules!)
        
        
        for _ in 0..<numberOfIterations {
            gameBoard.start()
            
            let board = gameBoard.getBoardState()
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width!, height: height!))
            let img = renderer.image { ctx in
                ctx.cgContext.setFillColor(UIColor.black.cgColor)

                for i in 0..<board.count {
                    for j in 0..<board[i].count {
                        let position = Position(x: j, y: i)
                        let cell = gameBoard.getCell(at: position, from: board)
                        
                        if cell!.isAlive {
                            let rectangle = CGRect(x: cell!.position.x, y: cell!.position.y, width: Cell.width, height: Cell.height)
                            ctx.cgContext.addRect(rectangle)
                            ctx.cgContext.drawPath(using: .fill)
                        }
                    }
                }
            }
            
            if let subView = self.gameBoardController.view.subviews.first(where: { $0 == self.gameBoardController.imgView}) {
                DispatchQueue.main.async {
                    subView.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async {
                self.gameBoardController.imgView = UIImageView(image: img)
                self.gameBoardController.view.addSubview(self.gameBoardController.imgView!)
            }
            
        }
    }
}
