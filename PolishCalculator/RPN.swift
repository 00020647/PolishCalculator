//
//  RPN.swift
//  PolishCalculator
//
//  Created by Sukhrob on 05/03/25.
//

import Foundation

class RPN {
    func calculate(_ input: String) -> Double {
        let output: String = GetExpression(input)
        let result: Double = Counting(output)
        return result
    }
    
    func GetExpression(_ input: String) -> String {
        var rpnForm: String = ""
        var stack: Stack<Character> = Stack<Character>()
        
        var index = input.startIndex
        
        while index < input.endIndex {
            let symbol = input[index]
            
            if isDelimeter(symbol) {
                index = input.index(after: index)
                continue
            }
            
            if symbol.isNumber {
                while index < input.endIndex && !isDelimeter(input[index]) && !isOperator(input[index]) {
                    rpnForm.append(input[index])
                    index = input.index(after: index)
                }
                rpnForm.append(" ")
                continue
            }
            

            if isOperator(symbol) {
                if symbol == "(" {
                    stack.push(symbol)
                } else if symbol == ")" {
                    if let popped = stack.pop() {
                        var op = popped
                        while op != "(" {
                            rpnForm.append(op)
                            rpnForm.append(" ")
                            guard let nextOp = stack.pop() else { break }
                            op = nextOp
                        }
                    }
                } else {
                    while let top = stack.peek(), getPriority(symbol) <= getPriority(top) {
                        rpnForm.append(stack.pop()!)
                        rpnForm.append(" ")
                    }
                    stack.push(symbol)
                }
            }
            index = input.index(after: index)
            
        }
        
        while stack.length() > 0 {
            rpnForm.append(String(stack.pop()!))
            rpnForm.append(" ")
        }
        
        return rpnForm
    }

    func Counting(_ output: String) -> Double {
        var result: Double = 0.0
        var stack: Stack<Double> = Stack<Double>()
        
        var index = output.startIndex
        
        while index < output.endIndex {
            
            if output[index].isNumber {
                var numbers: String = ""
                
                while index < output.endIndex && !isDelimeter(output[index]) && !isOperator(output[index]) {
                    numbers.append(output[index])
                    index = output.index(after: index)
                }
                stack.push(Double(numbers) ?? 0)
                index = output.index(before: index)
            } else if isOperator(output[index]) {
                let a = stack.pop() ?? 0.0
                let b = stack.pop() ?? 0.0
                
                switch output[index] {
                case "+":  result = b + a; break
                case "-" : result = b - a; break
                case "*":  result = b * a; break
                case "/":  result = b / a; break
                case "^":  result = pow(b, a); break
                default:
                    break
                }
                stack.push(result)
            }
            
            index = output.index(after: index)
        }
        
        return stack.peek() ?? 0.0
    }
    
    
    
    
    
    //MARK: - Methods for identification
    func isDelimeter(_ symbol: Character) -> Bool {
        return " =".contains(symbol)
    }
    
    func isOperator(_ symbol: Character) -> Bool {
        return "+-/*^()".contains(symbol)
    }
    
    func getPriority(_ symbol: Character) -> Int {
        switch symbol {
        case "(":
            return 0
        case ")":
            return 1
        case "+", "-":
            return 2
        case "*", "/":
            return 3
        case "^":
            return 4
        default:
            return 5
        }
    }
}



struct Stack<T> {
    private var items: [T] = []
    
    func peek() -> T? {
        return items.last
    }
    
    mutating func push(_ element: T) {
        items.append(element)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    func length() -> Int {
        return items.count
    }
}
