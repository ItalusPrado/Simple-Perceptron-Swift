//
//  ViewController.swift
//  Perceptron Simples
//
//  Created by Italus Pessoal on 07/01/17.
//  Copyright © 2017 Italus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let learningRate: CGFloat = 0.5
    let x0 = -1
    var currentIndex = 0
    var error: CGFloat = 0
    var lastIndexError = -1
    var circleComplete = false
    
    var weights = [CGFloat]()
    var arrayWithData = [[CGFloat]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weights = generateWeight(withSize: 4, andRandomNumbers: false)
        self.splitValues(withText: self.readFromFile(withFile: "flowers"))
        
        while !circleComplete && lastIndexError != currentIndex {
            if currentIndex == lastIndexError-1{
                circleComplete = true
            }
            compareResult(withResult: calculateWeight(withValues: self.arrayWithData[currentIndex]))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Generate the weight initial values
    func generateWeight(withSize size: Int, andRandomNumbers random: Bool) -> [CGFloat]{
    
        var weights = [CGFloat]()
        
        if !random {
            weights = [CGFloat](repeating: 0, count: size)
        } else {
            for _ in 1...size {
                let decimalRandom = String(format: "%.3f", CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
                weights.append(CGFloat(NumberFormatter().number(from: decimalRandom
                    )!))
            }
        }
        
        return weights
    }
    
    func calculateWeight(withValues values: [CGFloat]) -> CGFloat{
        var result: CGFloat = 0
        for index in 0..<values.count-1{
            result = result+(self.weights[index]*values[index])
        }
        if result > 0{
            return 1
        } else {
            return -1
        }
    }
    
    func compareResult(withResult result: CGFloat){
        if result == self.arrayWithData[currentIndex].last{
            print("Ok")
            self.currentIndex += 1
            if self.currentIndex == self.arrayWithData.count {
                self.currentIndex = 0
            }
        } else {
            print("Error")
            self.lastIndexError = self.currentIndex
            self.error = self.arrayWithData[currentIndex].last!-result
        }
    }
    
    func recalculateWeights(){
        for index in 0..<self.weights.count{
            self.weights[index] = self.weights[index]+learningRate*self.error*self.arrayWithData[currentIndex][index]
        }
    }
    
    // Read from file
    
    // Open file with data
    func readFromFile(withFile fileName: String) -> String{
        let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        var text: String
        do {
            text = try String(contentsOfFile: path!)
            //print(text)
        } catch {
            text = "error"
            print(text)
        }
        return text
    }
    
    // Generate array with the data
    func splitValues(withText text: String){
        var array = text.components(separatedBy: "\r\n")
        var arrayFinished = [[String]]()
        for index in 0...array.count-1{
            let minorText = array[index]
            arrayFinished.append(minorText.components(separatedBy: ","))
        }
        arrayFinished.removeLast()
        
        for array in arrayFinished{
            var floats = [CGFloat]()
            for index in array{
                floats.append(CGFloat(NumberFormatter().number(from: index
                    )!))
            }
            self.arrayWithData.append(floats)
        }
    }

}

