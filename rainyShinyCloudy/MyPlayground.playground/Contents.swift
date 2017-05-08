//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class ClassA {
    
    func someMethod(closure: @escaping () -> ()) {
        print("aa")
    }
}

class ClassB {
    let classA = ClassA()
    var sumeProperty = "Hello"
    
    func testClosure() {
        
        classA.someMethod {
            
          //self 가 캡쳐된다.
          self.sumeProperty = "클로저 안이당!!"
        }
        
    }
}

var myclassB = ClassB()
myclassB.testClosure()
myclassB.sumeProperty