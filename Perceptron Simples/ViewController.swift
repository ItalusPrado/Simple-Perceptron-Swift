//
//  ViewController.swift
//  Perceptron Simples
//
//  Created by Italus Pessoal on 07/01/17.
//  Copyright © 2017 Italus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let learningRate = 0.5
    let x0 = -1
    
    var arrayWithData = [[CGFloat]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generateWeight(withSize: 4, andRandomNumbers: false))
        self.splitValues(withText: self.readFromFile(withFile: "flowers"))
        print(arrayWithData)
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
    
    func calculateWeight(withWeight weights: [CGFloat], andValues values: [CGFloat]) -> CGFloat{
        var result: CGFloat = 0
        for index in 0..<values.count{
            result = result+(weights[index]*values[index])
        }
        if result > 0{
            return 1
        } else {
            return -1
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

