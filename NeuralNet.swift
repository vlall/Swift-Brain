// Creating a Neural Network from scratch

import Foundation

// Create exponents with '**'
operator infix ** {}
func ** (num: Double, power: Double) -> Double{
    return pow(num, power)
}

func randomFunc(a: Double, b:Double) -> (Double) {
    var randNum = arc4random_uniform(101)
    var output = (b-a)*Double(randNum) + (a)
    return output
}

func randomFunc(I:Double, J:Double)->(ArrayType){
    var fill = 0.0
    var m: Integer[] = []
    for index in 1...I{
        m.append([fill]*J)
    return m
    }
}

// Sigmoid function. Later, will add more options for standard 1/(1+e^-x)
func sigmoid(x: Double)->(Double){
    return tanh(x)
}

// Derivative of our sigmoid function
func dsigmoid(x: Double)->(Double){
    return 1.0 - x**2.0
}
