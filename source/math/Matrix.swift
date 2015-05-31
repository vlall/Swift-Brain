// Stole some of these from the original Neural Network. I'll make it look fancier soon.
class Matrix{

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
    
    func makeMatrix(I:NSInteger, J:NSInteger)->(Array<Array<Double>>){
        var NumColumns = I
        var NumRows = J
        var array = Array<Array<Double>>()
        for column in 0..NumColumns {
            array.append(Array(count:NumRows, repeatedValue:Double()))
        }
    
        return array
    }
    
    
}
