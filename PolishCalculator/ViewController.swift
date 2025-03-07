//
//  ViewController.swift
//  PolishCalculator
//
//  Created by Sukhrob on 05/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let theCheck = RPN()
        print(theCheck.calculate("((-2+2)*2+8*4)*4-5^2"))
        
        
        setupBackground()
        biggestStackView()
        setupButtons()
        
    }
    
    private func setupBackground() {
        let backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        view.backgroundColor = backgroundColor
    }
    
    private let buttonCharacters = [
        ["A","(",")","/"],
        ["7","8","9","*"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",",", "="]
    ]
    
    let stackView = UIStackView()
    
    private func biggestStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height/1.7),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    
    private func setupButtons() {
        for row in buttonCharacters {
            let rowStackViews = UIStackView()
            rowStackViews.axis = .horizontal
            rowStackViews.distribution = .fill
            rowStackViews.spacing = 10
            rowStackViews.backgroundColor = .green
            rowStackViews.translatesAutoresizingMaskIntoConstraints = false
            
            
            for character in row {
                let button = UIButton(type: .system)
                button.setTitle(character, for: .normal)
                button.backgroundColor = .yellow
//                button.addTarget(self, action: #selector(), for: .touchUpInside)
                rowStackViews.addArrangedSubview(button)
            }
            stackView.addArrangedSubview(rowStackViews)
        }
    }
    
    
}

