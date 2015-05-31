//Swift

class mathFunc{


func randomFunc(a: Double, b:Double) -> (Double) {
    var randNum = arc4random_uniform(100)/100
    var output = (b-a)*Double(randNum) + (a)
    return output
}

func dydx(x: Double)->(Double){
    return 1.0 - x**2.0
}

}
