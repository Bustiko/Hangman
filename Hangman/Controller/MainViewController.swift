//
//  ViewController.swift
//  Hangman
//
//  Created by Buse Karabıyık on 25.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var heartsLeft: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var hintsLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.68, green: 0.89, blue: 1.00, alpha: 1.00)
    }

    @IBAction func hintButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
    }
    
}

