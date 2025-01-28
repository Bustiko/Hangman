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
    
    
    private var wordManager = WordManager()
    private var updatedWord = Array<Character>()
    private var countForNextQuestion = 0
    private var indices: [Int] = []
    private var letterIndexCount = 0
    private var array = Array<Int>()
    private var numberOfHints = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.93, alpha: 1.00)
        wordManager.delegate = self
        wordManager.fetchData()
    }
    
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        if numberOfHints == 1 {
            DispatchQueue.main.async {
                sender.titleLabel?.text = "No hints left."
            }
            sender.isEnabled = false
        }
        numberOfHints -= 1
        hintsLeft.text = String(numberOfHints)
        for x in 0..<indices.count {
            array = array.filter({$0 != indices[x]})
            print(array)
        }
        let randomNumber = array.randomElement()
        updatedWord[randomNumber!] = words[0][randomNumber!]
        indices.append(randomNumber!)
        wordLabel.text = String(updatedWord)
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        
        if indices.count == words[0].count - 1 {
            performSegue(withIdentifier: "mainToWin", sender: self)
            DispatchQueue.main.async {
                self.heartsLeft.text = "5"
                self.hintsLeft.text = "3"
            }
            wordManager.fetchData()
        }
        
        if let wordText = wordLabel.text {
            updatedWord = Array(wordText)
        }
        
        for x in 0..<words[0].count {
            if String(words[0][x]) == (sender.titleLabel?.text)! {
                updatedWord[x] = words[0][x]
                if !indices.contains(x) {
                    indices.append(x)
                }
            }
        }
        
        if !words[0].contains((sender.titleLabel?.text)!) {
            let heartsAsInt = Int(heartsLeft.text!)!
            DispatchQueue.main.async {
                self.heartsLeft.text = String(heartsAsInt - 1)
            }
            if heartsLeft.text == "1" {
                DispatchQueue.main.async {
                    self.wordLabel.text = "All hearts used."
                }
                Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
                        self.performSegue(withIdentifier: "mainToLose", sender: self)
                }
                
                DispatchQueue.main.async {
                    self.heartsLeft.text = "5"
                    self.hintsLeft.text = "3"
                    
                }
                wordManager.fetchData()
            }
        }
        
        wordLabel.text = String(updatedWord)
        
    }
    
}

extension MainViewController: WordManagerDelegate {
    func didUpdateChanges(_ word: [String]) {
        letterIndexCount = word[0].count-1
        array = Array(0...letterIndexCount)
        indices = []
        print(word[0])
        updatedWord = Array(repeating: "-", count: word[0].count)
        DispatchQueue.main.async {
            for _ in word[0] {
                self.wordLabel.text? = String(self.updatedWord)
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


