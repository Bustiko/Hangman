//
//  WordManager.swift
//  Hangman
//
//  Created by Buse Karabıyık on 25.07.2023.
//

import Foundation

var words = [""]

protocol WordManagerDelegate {
    func didUpdateChanges(_ word: [String])
    func didFailWithError(_ error: Error)
}

struct WordManager {
    
    var delegate: WordManagerDelegate?
    
    let urlString = "https://random-word-api.vercel.app/api?words=1&type=uppercase"
    
    func fetchData() {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    delegate?.didFailWithError(e)
                    return
                } else {
                    if let safeData = data {
                        if let safeWords = parseJSON(safeData) {
                            words = safeWords
                            delegate?.didUpdateChanges(words)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [String]? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode([String].self, from: data)
            let word = decodedData
            return word
        }catch {
            print(error)
        }
    
        return nil
    }
}


