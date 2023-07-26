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
    var updatedWord = Array<Character>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.93, alpha: 1.00)
        wordManager.delegate = self
        wordManager.fetchData()
    }

    @IBAction func hintButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        if let wordText = wordLabel.text {
            updatedWord = Array(wordText)
        }
        
        for x in 0..<words[0].count {
            if String(words[0][x]) == (sender.titleLabel?.text)! {
                updatedWord[x] = words[0][x]
            }
        }
        
        wordLabel.text = String(updatedWord)
        
    }
    
}

extension MainViewController: WordManagerDelegate {
    func didUpdateChanges(_ word: [String]) {
        print(word[0])
        DispatchQueue.main.async {
            for _ in word[0] {
                self.wordLabel.text?.append("-")
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
    }
    
    
}


extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

