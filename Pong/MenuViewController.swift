//
//  MenuViewController.swift
//  Pong
//
//  Created by Giuseppe Cosenza on 10/12/24.
//

import Foundation
import UIKit

enum viewType {
    case singlePlayerView
    case multiPLayerView
    case settingsView
}

class MenuViewController: UIViewController {
    
    @IBAction func SinglePlayerButton(_ sender: Any) {
        MoveTo(view: .singlePlayerView)
    }
    
    @IBAction func MultiPlayerButton(_ sender: Any) {
        MoveTo(view: .multiPLayerView)
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
        MoveTo(view: .settingsView)
    }
    
    func MoveTo(view: viewType) {
        let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! GameViewController
        
        currentViewType = view
        
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
}
