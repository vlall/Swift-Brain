//
//  main.swift
//  swiftex1
//
//  Created by V Lall on 6/8/14.
//  Copyright (c) 2014 swiftintel. All rights reserved.
//

import Foundation

operator infix ** {}
func ** (num: Double, power: Double) -> Double{
    return pow(num, power)
}

operator infix *& {}
func *& (I: Double, J: Double) -> Array<Array<Double>>{
    var fill = 0.0
    var m = Array<Array<Double>>()
    for index in 1...I{
        for nextIndex in 1...J{
            m.append([fill])
        }
    }
    return m
}

func randomFunc(a: Double, b:Double) -> (Double) {
    var randNum = arc4random_uniform(100)/100
    var output = (b-a)*Double(randNum) + (a)
    return output
}

func makeMatrix(I:Double, J:Double)->(Array<Array<Double>>){
    var fill = 0.0
    var m = Array<Array<Double>>()
    for index in 1...I{
        for nextIndex in 1...J{
            m.append([fill])
        }
    }
    return m
}

//sigmoid function. Later, will add more options for standard 1/(1+e^-x)
func sigmoid(x: Double)->(Double){
    return tanh(x)
}


// derivative of our sigmoid function
func dsigmoid(x: Double)->(Double){
    return 1.0 - x**2.0
}

class NN {

    // Using default values may break this... Always initialize ni,nh,no
    var ni: Double = 0.0
    var nh: Double = 0.0
    var no: Double = 0.0
    var ai = []
    var ah = []
    var ao = []
    var wi = []
    var wo = []
    var ci = []
    var co = []
    
    init(ni:Double, nh:Double, no:Double) {
        // number of input, hidden, and output nodes
        self.ni = ni+1 // +1 for bias node
        self.nh = nh
        self.no = no
        
        // activations for nodes CHANGE THIS*******
        self.ai = [1.0]//*self.ni
        self.ah = [1.0]//*self.nh
        self.ao = [1.0]//*self.no
        
        //create weights
        self.wi = makeMatrix(4.0,4.0)
        self.wi = makeMatrix(self.ni, self.nh)
        self.wo = makeMatrix(self.nh, self.no)
        
        for i in 1...(self.ni){
            for j in 1...(self.nh){
                self.wi[i][j] = randomFunc(-0.2, 0.2)
            }
        }
        for j in 1...(self.nh){
            for k in 1...(self.no){
                self.wo[j][k] = randomFunc(-2.0, 2.0)
            }
        }
        
        // last change in weights for momentum
        self.ci = makeMatrix(self.ni, self.nh)
        self.co = makeMatrix(self.nh, self.no)

    }
    
}

let myFirstNN = NN(ni: 4,nh: 4,no: 4)
