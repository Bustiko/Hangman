//
//  LosePageContoller.swift
//  Hangman
//
//  Created by Buse Karabıyık on 26.07.2023.
//

import UIKit

class LostPageController: UIViewController {
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.93, alpha: 1.00)
    }
    
    
    @IBAction func mainPageButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
