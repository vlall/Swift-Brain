//
//  Matrix.swift
//  Brain
//
//  Created by Vishal on 201X-XX-XX.
//  Copyright (c) 2015 Vishal. All rights reserved.
//
//  Stole some of these from the original Neural Network. I'll make it look fancier soon.
//

import Foundation

infix operator *& {}
func *& (fill: Array<Double>, I: NSInteger) -> Array<Double> {
    var m = Array<Double>()
    let length = fill.count-1
    for _ in 1...I{
        for index in 0...length{
            m.append(fill[index])
        }
    }
    
    return m
}

class Matrix {

    
    func makeMatrix(I:NSInteger, J:NSInteger)->(Array<Array<Double>>){
        let NumColumns = I
        let NumRows = J
        var array = Array<Array<Double>>()
        for _ in 0..<NumColumns {
            array.append(Array(count:NumRows, repeatedValue:Double()))
        }
    
        return array
    }
}
