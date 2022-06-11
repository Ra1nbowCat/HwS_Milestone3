//
//  ViewController.swift
//  Milestone3
//
//  Created by Илья Лехов on 10.06.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let submitButton = UIButton()
    let wordTextField = UITextField()
    let guessTextField = UITextField()
    let statusLabel = UILabel()
    var randomWordArray = ["milk", "papik", "kek", "Hehs", "meh1", "meh ", "meh,"]
    let cheers = ["Good job!", "Well done!", "Keep going!"]
    var currentWord = [Character]()
    let customRange = NSRange(location: 0, length: 1)
    var questionArray = [Character]()
    var score = 0 {
        didSet {
            statusLabel.text = "Score: \(score)"
        }
    }
    var characterObserver = "" {
        didSet {
            let arrayOfObserver = Array(characterObserver)
            if arrayOfObserver.count > 0 {
                for (index, char) in currentWord.enumerated() {
                    if char == arrayOfObserver[0] {
                        questionArray.remove(at: index)
                        questionArray.insert(char, at: index)
                        wordTextField.text = String(questionArray)
                        score += 1
                    } else if !currentWord.contains(arrayOfObserver[0]) {
                        score -= 1
                        return
                    }
                }
                
                if questionArray == currentWord {
                    statusLabel.text! += """
                    
                    \(cheers.randomElement()!)
                    """
                    wordTextField.text = ""
                    addWordToTextField()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guessTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        guessTextField.delegate = self
        
        addSubviews()
        subviewsSettings()
        makeConstraints()
        addWordToTextField()
    }
    
    func addSubviews() {
        view.addSubview(wordTextField)
        view.addSubview(guessTextField)
        view.addSubview(statusLabel)
        view.addSubview(submitButton)
    }
    
    func addWordToTextField() {
        //Немного дурацки, что приходится это все засовывать в разные итерации, но вместе в рамках одной итерации не работало, ругался на индекс
        for (index,word) in randomWordArray.enumerated() {
            let decimalCharacters = CharacterSet.decimalDigits
            let decimalRange = word.rangeOfCharacter(from: decimalCharacters)
            if decimalRange != nil {
                print("Numbers or signs found in \(word)")
                randomWordArray.remove(at: index)
                print(randomWordArray)
            }
        }
        for (index,word) in randomWordArray.enumerated() {
            let signsCharacters = CharacterSet.whitespacesAndNewlines
            let signsRange = word.rangeOfCharacter(from: signsCharacters)
            if signsRange != nil {
                print("Whitespace or lines found in \(word)")
                randomWordArray.remove(at: index)
                print(randomWordArray)
            }
        }
        for (index,word) in randomWordArray.enumerated() {
            let punctuationCharacters = CharacterSet.punctuationCharacters
            let punctuationRange = word.rangeOfCharacter(from: punctuationCharacters)
            if punctuationRange != nil {
                print("Punctuation found in \(word)")
                randomWordArray.remove(at: index)
                print(randomWordArray)
            }
        }
        currentWord = Array((randomWordArray.randomElement()?.lowercased())!)
        let wordLength = currentWord.count
            for _ in 0..<wordLength {
                wordTextField.text! += Array("?")
        }
        questionArray = Array(wordTextField.text!)
    }

    func subviewsSettings() {
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.isUserInteractionEnabled = false
        wordTextField.font = UIFont.systemFont(ofSize: 50)
        
        guessTextField.translatesAutoresizingMaskIntoConstraints = false
        guessTextField.font = UIFont.systemFont(ofSize: 35)
        guessTextField.layer.borderColor = UIColor.lightGray.cgColor
        guessTextField.layer.borderWidth = 1
        guessTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 25)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 3
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit character", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.addTarget(self, action: #selector(submitCharacter), for: .touchUpInside)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            guessTextField.centerYAnchor.constraint(equalTo: wordTextField.centerYAnchor, constant: view.frame.height / 4),
            guessTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5),
            
            statusLabel.centerYAnchor.constraint(equalTo: wordTextField.centerYAnchor, constant: -(view.frame.height / 4)),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: wordTextField.centerYAnchor, constant: view.frame.height / 3)
        ])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
    
    @objc func submitCharacter() {
        if let unwrapped = guessTextField.text {
            characterObserver = unwrapped
            guessTextField.text?.removeAll()
        }
    }

}

