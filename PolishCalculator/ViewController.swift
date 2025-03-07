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
        setupLabel()
        
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
        stackView.distribution = .fillEqually
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
            rowStackViews.distribution = .fillEqually
            rowStackViews.spacing = 10
            rowStackViews.backgroundColor = .green
            rowStackViews.translatesAutoresizingMaskIntoConstraints = false
            
            
            for character in row {
                let button = UIButton(type: .system)
                button.setTitle(character, for: .normal)
                button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                button.setTitleColor(.white, for: .normal)
                
                //Round Corners
                button.layer.cornerRadius =  45
                button.layer.masksToBounds = true
                button.addTarget(self, action: #selector(handleButtons), for: .touchUpInside)
                rowStackViews.addArrangedSubview(button)
                
            }
            stackView.addArrangedSubview(rowStackViews)
        }
    }
    @objc func handleButtons(_ param: UIButton) {
        print(param.titleLabel?.text ?? "")

        
        switch param.titleLabel?.text {
        case "1":
            resultLabel.text = "1"
        case "2":
            resultLabel.text = "2"
        case "3":
            resultLabel.text = "3"
        case "4":
            resultLabel.text = "4"
        case "5":
            resultLabel.text = "5"
        case "6":
            resultLabel.text = "6"
        case "7":
            resultLabel.text = "7"
        case "8":
            resultLabel.text = "8"
        case "9":
            resultLabel.text = "9"
        default:
            resultLabel.text = ""
        }
    }
    
    //Result Label
    let resultLabel = UILabel()
    private func setupLabel(){
        resultLabel.textAlignment = .right
        resultLabel.textColor = .white
        resultLabel.text = "0"
        resultLabel.font = UIFont.systemFont(ofSize: 60)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
    }
}
