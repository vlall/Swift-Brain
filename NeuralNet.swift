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
func *& (fill: Double, I: NSInteger) -> Array<Double>{
    var m = Array<Double>()
    for index in 1...I{
            m.append(fill)
    }
    return m
}

func randomFunc(a: Double, b:Double) -> (Double) {
    var randNum = arc4random_uniform(100)/100
    var output = (b-a)*Double(randNum) + (a)
    return output
}

func makeMatrix(I:NSInteger, J:NSInteger)->(Array<Array<Double>>){
    var NumColumns = I
    var NumRows = J
    var array = Array<Array<Double>>()
    for column in 0..NumColumns {
        array.append(Array(count:NumRows, repeatedValue:Double()))
    }

    return array
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
    var ni = 2
    var nh = 2
    var no = 2
    var ai = []
    var ah = []
    var ao = []
    var wi = Array<Array<Double>>()
    var wo = Array<Array<Double>>()
    var ci = Array<Array<Double>>()
    var co = Array<Array<Double>>()
    
    init(ni:NSInteger, nh:NSInteger, no:NSInteger) {
        // number of input, hidden, and output nodes
        self.ni = ni+1 // +1 for bias node
        self.nh = nh
        self.no = no
        
        // activations for nodes
        self.ai = 1.0*&self.ni
        self.ah = 1.0*&self.nh
        self.ao = 1.0*&self.no
        
        //create weights
        self.wi = makeMatrix(self.ni, self.no)
        self.wo = makeMatrix(self.nh, self.no)
        
        for i in 0...(self.ni-1){
            println(i)
            for j in 0...(self.nh-1){
                self.wi[i][j]=randomFunc(-0.2, 0.2)
            }
            println(self.wi[i])

        }
        for j in 0...(self.nh-1){
            for k in 0...(self.no-1){
                self.wo[j][k] = randomFunc(-2.0, 2.0)
            }
        }

        
        // last change in weights for momentum
        self.ci = makeMatrix(self.ni, self.nh)
        self.co = makeMatrix(self.nh, self.no)

    }
    
    func update(self,inputs:NSInteger) -> (Array) {
        if (inputs.count != self.ni-1){
            println("wrong number of inputs")
        }
        // input activations
        for i in 1...(self.ni-1){
        //self.ai[i] = sigmoid(inputs[i])
            self.ai[i] = inputs[i]
        }
        // hidden activations
        for j in 1...(self.nh-1){
            var sum = 0.0
            for i in 1...(self.ni-1){
                sum = sum + self.ai[i] * self.wi[i][j]
            }
            self.ah[j] = sigmoid(sum)
            
        }
        // output activations
        for k in 1...(self.no){
            var sum = 0.0
            for j in 1...(self.nh){
                sum = sum + self.ah[j] * self.wo[j][k]
            }
            self.ao[k] = sigmoid(sum)
        }
        return self.ao[]
    }
}

let myFirstNN = NN(ni: 10,nh: 10,no: 10)
var x = 2.0*&4
println(x)
