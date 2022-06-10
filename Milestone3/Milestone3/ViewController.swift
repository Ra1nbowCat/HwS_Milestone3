//
//  ViewController.swift
//  Milestone3
//
//  Created by Илья Лехов on 10.06.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let wordTextField = UITextField()
    let guessTextField = UITextField()
    let statusLabel = UILabel()
    let randomWordArray = ["milk", "papik", "kek"]
    var currentWord = [Character]()
    let customRange = NSRange(location: 0, length: 1)
    var questionArray = [Character]()
    var questionObserver = "" {
        didSet {
            
        }
    }
    var characterObserver = "" {
        didSet {
            statusLabel.text = characterObserver
                print("start")
                var arrayOfObserver = Array(characterObserver)
                print(arrayOfObserver)
                print(currentWord)
            print(questionArray)
                
                if arrayOfObserver.count > 0 {
                    // Работает сильно лучше, но надо будет понять, как добавлять вместе одинаковые буквы!
                    for char in currentWord {
                        if char == arrayOfObserver[0] {
                            print("Found it!")
                            questionArray.remove(at: currentWord.firstIndex(of: char)!)
                            questionArray.insert(char, at: currentWord.firstIndex(of: char)!)
                            wordTextField.text = String(questionArray)
                    }
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
        textFieldChanged(guessTextField)
    }
    
    func addSubviews() {
        view.addSubview(wordTextField)
        view.addSubview(guessTextField)
        view.addSubview(statusLabel)
    }
    
    func addWordToTextField() {
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
        guessTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 25)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 3
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
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
    
    @objc func textFieldChanged (_ textField: UITextField) {
        if let unwrapped = textField.text {
            characterObserver = unwrapped
        }
    }

}

