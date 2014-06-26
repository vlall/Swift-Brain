//  Created by V Lall on 6/8/14.
//  Copyright (c) 2014 swiftintel. All rights reserved.
//

import Foundation

operator infix ** {}
func ** (num: Double, power: Double) -> Double{
    return pow(num, power)
}

operator infix *& {}
func *& (fill: Array<Double>, I: NSInteger) -> Array<Double>{
    var m = Array<Double>()
    var length = fill.count-1
    for times in 1...I{
        for index in 0...length{
            m.append(fill[index])
        }
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
    var ai = Array<Double>()
    var ah = Array<Double>()
    var ao = Array<Double>()
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
        self.ai = [1.0]*&self.ni
        self.ah = [1.0]*&self.nh
        self.ao = [1.0]*&self.no
        
        //create weights
        self.wi = makeMatrix(self.ni, self.no)
        self.wo = makeMatrix(self.nh, self.no)
        
        for i in 0...(self.ni-1){
            for j in 0...(self.nh-1){
                self.wi[i][j]=randomFunc(-0.2, 0.2)
            }
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
    func update(inputs:Array<Double>) -> (Array<Double>) {
        if (inputs.count != self.ni){
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
        for k in 1...(self.no-1){
            var sum = 0.0
            for j in 1...(self.nh-1){
                sum = sum + self.ah[j] * self.wo[j][k]
            }
            self.ao[k] = sigmoid(sum)
        }
        return self.ao
    }
    
    func backPropagate(targets:Array<Double>, N:Double, M:Double)->(Double){
        if targets.count != self.no{
            println("wrong number of target values")
        }
        // calculate error terms for output
        var output_deltas = [0.0] *& self.no
        for k in 0..(self.no){
            var error = targets[k]-self.ao[k]
            output_deltas[k] = dsigmoid(self.ao[k]) * error
        }
        // calculate error terms for hidden
       var hidden_deltas = [0.0] *& self.nh
        for j in 0..(self.nh){
            var error = 0.0
            for k in 0..(self.no){
                error = error + output_deltas[k]*self.wo[j][k]
            }
            hidden_deltas[j] = dsigmoid(self.ah[j]) * error
        }
        // update output weights
        for j in 0..(self.nh){
            for k in 0..(self.no){
                var change = output_deltas[k]*self.ah[j]
                self.wo[j][k] = self.wo[j][k] + N*change + M*self.co[j][k]
                self.co[j][k] = change
                //print N*change, M*self.co[j][k]
            }
        }
        // update input weights
        for i in 0..(self.ni){
            for j in 0..(self.nh){
                var change = hidden_deltas[j]*self.ai[i]
                self.wi[i][j] = self.wi[i][j] + N*change + M*self.ci[i][j]
                self.ci[i][j] = change
            }
        }
        // calculate error
        var error = 0.0
        for k in 0...(targets.count){
            error = error + 0.5*(targets[k]-self.ao[k])**2
        }
        return error
    }
    
    func test(patterns:Array<Array<Array<Double>>>)->(){
        for p in 0...patterns.count{
         //   println("\(patterns[p][0]) ->  \(self.update(patterns[p][0]))")
        }
    }
    func weights()->(){
        print("Input weights:")
        for i in 0..(self.ni){
            println(self.wi[i])
            println("Output weights:")
        }
        for j in 0..(self.nh){
            print(self.wo[j])
        }
    
    }
    func train(patterns:Array<Array<Array<Double>>>, iterations:NSInteger=1000, N:Double=0.5, M:Double=0.1){
    // N: learning rate
    // M: momentum factor
        for i in 0..iterations{
                var error = 0.0
            for p in 0..patterns.count-1{
                var inputs = patterns[p][0]
                var targets = patterns[p][1]
                self.update(inputs)
               // error = error + self.backPropagate(targets, N: N, M: M)
            }
            if i % 100 == 0{
                println("error \(error)")
            }
        }
    }
}
func demo()->(){
//Teach network XOR function
    var pat = Array<Array<Array<Double>>>()

    pat = [
    [[0,0], [0]],
    [[0,1], [1]],
    [[1,0], [1]],
    [[1,1], [0]]
    ]

    // create a network with two input, two hidden, and one output nodes
    let n = NN(ni: 2,nh: 2,no: 1)
    // train it with some patterns
    n.train(pat)
    // test it
    n.test(pat)
    }

//let myFirstNN = NN(ni: 10,nh: 10,no: 10)
//var x = [2.0]*&4
println(demo())



