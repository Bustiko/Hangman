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
    var array = Array<Int>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.93, alpha: 1.00)
        wordManager.delegate = self
        wordManager.fetchData()
    }
    
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        print(countForNextQuestion)
        print(letterIndexCount)
        print(array)
        
        for x in 0..<indices.count {
            array = array.filter({$0 != indices[x]})
            print(array)
        }
        let randomNumber = array.randomElement()
//                countForNextQuestion += 1
        updatedWord[randomNumber!] = words[0][randomNumber!]
        indices.append(randomNumber!)
        wordLabel.text = String(updatedWord)
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        if let wordText = wordLabel.text {
            updatedWord = Array(wordText)
        }
        
        for x in 0..<words[0].count {
            if String(words[0][x]) == (sender.titleLabel?.text)! {
//                countForNextQuestion += 1
                updatedWord[x] = words[0][x]
                indices.append(x)
            }
        }
        
        if !words[0].contains((sender.titleLabel?.text)!) {
            let heartsAsInt = Int(heartsLeft.text!)!
            DispatchQueue.main.async {
                self.heartsLeft.text = String(heartsAsInt - 1)
            }
            if heartsLeft.text == "0" {
                DispatchQueue.main.async {
                    self.wordLabel.text = "All hearts used."
                }
            }
        }
        
        wordLabel.text = String(updatedWord)
        
//        if countForNextQuestion == words[0].count {
//            countForNextQuestion = 0
//            wordLabel.text = ""
//            wordManager.fetchData()
//        }
    }
    
    
    @IBAction func newWordButtonPressed(_ sender: UIButton) {
        wordManager.fetchData()
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
extension String {
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}
extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}

