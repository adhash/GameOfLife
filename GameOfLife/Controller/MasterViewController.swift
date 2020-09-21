//
//  DetailViewController.swift
//  GameOfLife
//
//  Created by wojtek on 24/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet weak var numberOfIterationsInput: UITextField!
    @IBOutlet weak var numberOfIterationsLabel: UILabel!
    @IBOutlet weak var gameBoardView: UIView!
    
    private var gameRules: GameRules?
    private var imgView: UIImageView?
    
    init(gameRules: GameRules) {
        super.init(nibName: nil, bundle: nil)
        self.imgView = nil
        self.gameRules = gameRules
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.gameBoardView.backgroundColor = .red
        self.numberOfIterationsLabel.text = ""
    }
    
    @IBAction func update_onClick(_ sender: Any) {
        let noOfIter = Int(self.numberOfIterationsInput.text!) ?? 100
        let width = Int(exactly: self.gameBoardView.frame.size.width)
        let height = Int(exactly: self.gameBoardView.frame.size.height)
        let gameBoard = GameBoard(width: width! / Cell.width, height: height! / Cell.height, rules: self.gameRules!)
        
        
        DispatchQueue.global(qos: .background).async {
            for i in 0..<noOfIter {
                gameBoard.start()
                DispatchQueue.main.sync {
                    self.numberOfIterationsLabel.text = "\(i + 1) \\ \(noOfIter)"
                }
                
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
                
                if let subView = self.gameBoardView.subviews.first(where: { $0 == self.imgView }) {
                    DispatchQueue.main.async {
                        subView.removeFromSuperview()
                    }
                }
                
                DispatchQueue.main.sync {
                    self.imgView = UIImageView(image: img)
                    self.gameBoardView.addSubview(self.imgView!)
                }
            }
        
        }
    }
}
