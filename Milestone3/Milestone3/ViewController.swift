//
//  ViewController.swift
//  Milestone3
//
//  Created by Илья Лехов on 10.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let wordTextField = UITextField()
    let guessTextField = UITextField()
    var randomWord = ["Milk", "Coconut", "Computer", "Language", "Book"]

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        subviewsSettings()
        makeConstraints()
        addWordToTextField()
    }
    
    func addSubviews() {
        view.addSubview(wordTextField)
        view.addSubview(guessTextField)
    }
    
    func addWordToTextField() {
        wordTextField.text = randomWord.randomElement()?.lowercased()
    }

    func subviewsSettings() {
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.isUserInteractionEnabled = false
        wordTextField.font = UIFont.systemFont(ofSize: 50)
        
        guessTextField.translatesAutoresizingMaskIntoConstraints = false
        guessTextField.font = UIFont.systemFont(ofSize: 35)
        guessTextField.layer.borderColor = UIColor.lightGray.cgColor
        guessTextField.layer.borderWidth = 1
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            guessTextField.centerYAnchor.constraint(equalTo: wordTextField.centerYAnchor, constant: view.frame.height / 4),
            guessTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5)
        ])
    }

}

