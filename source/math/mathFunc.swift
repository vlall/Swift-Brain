//
//  MathFunc.swift
//  Brain
//
//  Created by Vishal on 201X-XX-XX.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

import Foundation

class mathFunc {
    func randomFunc(a: Double, b:Double) -> (Double) {
        let randNum = arc4random_uniform(100)/100
        let output = (b-a)*Double(randNum) + (a)
    
        return output
    }

    func dydx(x: Double)->(Double){
        return 1.0 - x**2.0
    }
}
