//
//  ViewController.swift
//  Milestone3
//
//  Created by Илья Лехов on 10.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let wordTextField = UITextField()
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
    }
    
    func addWordToTextField() {
        wordTextField.text = randomWord.randomElement()
    }

    func subviewsSettings() {
        wordTextField.translatesAutoresizingMaskIntoConstraints = false
        wordTextField.isUserInteractionEnabled = false
        wordTextField.font = UIFont.systemFont(ofSize: 50)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

