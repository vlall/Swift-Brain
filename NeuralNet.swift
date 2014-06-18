// Creating a Neural Network from scratch

import Foundation

// Create exponents with '**', must be defined at the beginning
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
    var randNum = arc4random_uniform(1000)/1000
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

// Sigmoid function. Later, will add more options for standard 1/(1+e^-x)
func sigmoid(x: Double)->(Double){
    return tanh(x)
}

// Derivative of our sigmoid function
func dsigmoid(x: Double)->(Double){
    return 1.0 - x**2.0
}

class NN {
    var ni: Double = 0.0
    var nh: Double = 0.0
    var no: Double = 0.0
    var ai: Array = []
    var ah: Array = []
    var ao: Array = []
    var wi: Array = []
    var wo: Array = []
    var ci: Array = []
    var co: Array = []
    init(ni:Double, nh:Double, no:Double) {
        // number of input, hidden, and output nodes
        self.ni = ni+1 // +1 for bias node
        self.nh = nh
        self.no = no
        
        // activations for nodes
        self.ai = [1.0]//*self.ni
        self.ah = [1.0]//*self.nh
        self.ao = [1.0]//*self.no
        
        //create weights
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
