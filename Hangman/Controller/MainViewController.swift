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
    
    var wordManager = WordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.93, alpha: 1.00)
        wordManager.delegate = self
        wordManager.fetchData()
    }

    @IBAction func hintButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
    }
    
}

extension MainViewController: WordManagerDelegate {
    func didUpdateChanges(_ word: [String]) {
        DispatchQueue.main.async {
            self.wordLabel.text = word[0]
        }
    }
    
    func didFailWithError(_ error: Error) {
    }
    
    
}

