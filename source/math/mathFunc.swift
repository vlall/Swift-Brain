//
//  MathFunc.swift
//  Brain
//
//  Created by Vishal on 201X-XX-XX.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

class mathFunc {
    func randomFunc(a: Double, b:Double) -> (Double) {
        var randNum = arc4random_uniform(100)/100
        var output = (b-a)*Double(randNum) + (a)
    
        return output
    }

    func dydx(x: Double)->(Double){
        return 1.0 - x**2.0
    }
}
