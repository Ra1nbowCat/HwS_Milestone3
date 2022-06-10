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
    let randomWordArray = ["Milk", "Coconut", "Computer", "Language", "Book"]
    var currentWord: String?
    let customRange = NSRange(location: 0, length: 1)

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
    }
    
    func addWordToTextField() {
        currentWord = randomWordArray.randomElement()?.lowercased()
        let wordLength = currentWord?.count
        if let unwrapped = wordLength {
            for _ in 0..<unwrapped {
                wordTextField.text! += "?"
                statusLabel.text = "\(unwrapped) : \(currentWord!)"
            }
        }
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

}

