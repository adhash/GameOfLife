//
//  DetailViewController.swift
//  GameOfLife
//
//  Created by wojtek on 24/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import UIKit

class DetailViewController: GameBoardController, UISplitViewControllerDelegate {
    
    init(gameRules: GameRules) {
        super.init(nibName: nil, bundle: nil)
        self.imgView = nil
        self.gameRules = gameRules
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didChangeIterations(notifiction:)),
                                               name: Notification.Name(Application.numberOfIterations.rawValue),
                                               object: nil)
    }
    @objc
    func didChangeIterations(notifiction: Notification) {
        let noOfIter = Int(notifiction.object as! String) ?? 100
        
        let startGameOperation = StartGameOperation(noOfIterations: noOfIter, gameBoardController: self)
        let operationQueque: OperationQueue = {
            let operQueque = OperationQueue()
            operQueque.name = "game.queque"
            
            return operQueque
        }()
        
        operationQueque.addOperation(startGameOperation)
    }
}
