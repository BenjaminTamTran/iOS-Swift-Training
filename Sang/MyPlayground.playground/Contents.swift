//statements
//BREAK

//var i = 5
//var evenCount = 0
//
//while true {
//    if i % 2 == 0 {
//        print("Even")
//        evenCount += 1
//        if evenCount == 5 {
//            break
//        }
//    }
//    print(i)
//    i += 1
//}


//var count = 1
//loop: while true {
//    print("Start")
//    for i in 1...3 {
//        print(i)
//        if(count == 5) {
//            break loop
//        }
//    }
//    count += 1
//}


//CASE, DEFAULT

//var i: Int = 1
//let someCharacter: Character = "a"
//switch someCharacter {
//case "a", "e", "i", "o", "u":
//    print("\(someCharacter) is a vowel")
//    ++i
//    fallthrough
//case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
//     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
//    print("\(someCharacter) is a consonant")
//    ++i
//default:
//    print("\(someCharacter) is not a vowel or a consonant")
//}
//i



//COUTINUE

//let puzzleInput = "great minds think alike"
//var puzzleOutput = ""
//for character in puzzleInput.characters {
//    switch character {
//    case "a", "e", "i", "o", "u", " ":
//        continue
//    default:
//        puzzleOutput.append(character)
//    }
//    print(puzzleOutput)
//}
//print(puzzleOutput)


//DEFER: 

//for i in 1...10 {
//    defer { print ("Deferred \(i)") }
//    print ("In \(i)")
//    print ("Out \(i)")
//}

//

//func testDefer(){
//    defer { print("number 1") }
//    defer { print("number 2") }
//    defer { print("number 3") }
//    print("number 4")
//    print("number 5")
//    print("number 6")
//}
//testDefer()


////why need defer statements
//func writeLog() {
//    let file = openFile()
//    
//    let hardwareStatus = fetchHardwareStatus()
//    guard hardwareStatus != "disaster" else { return }
//    file.write(hardwareStatus)
//    
//    let softwareStatus = fetchSoftwareStatus()
//    guard softwareStatus != "disaster" else { return }
//    file.write(softwareStatus)
//    
//    let networkStatus = fetchNetworkStatus()
//    guard neworkStatus != "disaster" else { return }
//    file.write(networkStatus)
//    
//    defer{ closeFile(file) }
//}

//IF - ELSE

//var size = 10
//
//// Test size var in if, else-if block.
//if size >= 20 {
//    print("Big")
//} else if size >= 10 {
//    print("Medium")
//} else {
//    print("Small")
//}
//
//func test(x: Int) {
//    let y = x == 10 ? 5 : 0
//    print(y)
//}
//
//// Call ternary test method.
//test(10)
//test(200)

//GUARD - ELSE

//func printArea(x: Int, y: Int) {
//    // Validate that "x" argument is valid.
//    guard x >= 1 else {
//        print("X invalid")
//        return
//    }
//    // Validate "y" argument.
//    guard y >= 1 else {
//        print("Y invalid")
//        return
//    }
//    // Print area.
//    let area = x * y
//    print(area)
//}

//// Call printArea.
//printArea(5, y: 10)
//// Use invalid "X" then invalid "Y" arguments.
//printArea(0, y: 1)
//printArea(2, y: 0)
//
//func printSum(values: [Int]) {
//    
//    guard let initial = values.first else {
//        print("No initial element")
//        return
//    }
//    // Print first element.
//    print("First: \(initial)")
//    
//    // Sum elements.
//    var sum = 0
//    for element in values {
//        sum += element
//    }
//    // Print the sum.
//    print("Sum: \(sum)")
//}
//
//// Use printSum func.
//printSum([])
//printSum([10, 11])

//var i = 0
//while true {
//    i += 1
//    guard i % 2 == 0 else {
//        continue
//    }
//    guard i <= 10 else {
//        break
//    }
//    print("Number: \(i)")
//}

//FALLTHROUGH

//let integerToDescribe = 5
//var description = "The number \(integerToDescribe) is"
//switch integerToDescribe {
//case 2, 3, 5, 7, 11, 13, 17, 19:
//    description += " a prime number, and also"
//    fallthrough
//default:
//    description += " an integer."
//}
//print(description)

//IN

//for _ in 0...3 {
//    print("Hello")
//}

//SWITCH - WHERE

//let approximateCount = 12
//let countedThings = "moons orbiting Saturn"
//var naturalCount: String
//switch approximateCount {
//case 0:
//    naturalCount = "no"
//case 1..<5:
//    naturalCount = "a few"
//case 5..<12:
//    naturalCount = "several"
//case 12..<100:
//    naturalCount = "dozens of"
//case 100..<1000:
//    naturalCount = "hundreds of"
//default:
//    naturalCount = "many"
//}
//print("There are \(naturalCount) \(countedThings).")

//let somePoint = (1.5, 1.5)
//switch somePoint {
//case (0, 0):
//    print("(0, 0) is at the origin")
//case (_, 0):
//    print("(\(somePoint.0), 0) is on the x-axis")
//case (0, _):
//    print("(0, \(somePoint.1)) is on the y-axis")
//case (-2...2, -2...2):
//    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
//default:
//    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
//}


//let anotherPoint = (2, 0)
//switch anotherPoint {
//case (let x, 0):
//    print("on the x-axis with an x value of \(x)")
//case (0, let y):
//    print("on the y-axis with a y value of \(y)")
//case let (x, y):
//    print("somewhere else at (\(x), \(y))")
//}


//let yetAnotherPoint = (1, -1)
//switch yetAnotherPoint {
//case let (x, y) where x == y:
//    print("(\(x), \(y)) is on the line x == y")
//case let (x, y) where x == -y:
//    print("(\(x), \(y)) is on the line x == -y")
//case let (x, y):
//    print("(\(x), \(y)) is just some arbitrary point")
//}


// Expressions and Types

//class Subjects {
//    var physics: String
//    init(physics: String) {
//        self.physics = physics
//    }
//}
//
//class Chemistry: Subjects {
//    var equations: String
//    init(physics: String, equations: String) {
//        self.equations = equations
//        super.init(physics: physics)
//    }
//}
//
//class Maths: Subjects {
//    var formulae: String
//    init(physics: String, formulae: String) {
//        self.formulae = formulae
//        super.init(physics: physics)
//    }
//}
//
//let sa = [
//    Chemistry(physics: "solid physics", equations: "Hertz"),
//    Maths(physics: "Fluid Dynamics", formulae: "Giga Hertz"),
//    Chemistry(physics: "Thermo physics", equations: "Decibels"),
//    Maths(physics: "Astro Physics", formulae: "MegaHertz"),
//    Maths(physics: "Differential Equations", formulae: "Cosine Series")]
//
//var chemCount = 0
//var mathsCount = 0
//
//for item in sa {
//    if item is Chemistry {
//        chemCount+=1
//    } else if item is Maths {
//        mathsCount+=1
//    }
//}
//print(chemCount)
//print(mathsCount)
//
//for item in sa {
//    if let printl = item as? Chemistry {
//        print("Chemistry topics are: '\(printl.physics)', \(printl.equations)")
//    } else if let example = item as? Maths {
//        print("Maths topics are: '\(example.physics)',  \(example.formulae)")
//    }
//}

//class SomeBaseClass {
//    class func printClassName() {
//        print("SomeBaseClass")
//    }
//}
//class SomeSubClass: SomeBaseClass {
//    override class func printClassName() {
//        print("SomeSubClass")
//    }
//}
//let someInstance: SomeBaseClass = SomeSubClass()
//someInstance.dynamicType.printClassName()

//enum ErrorSpecial: ErrorType {
//    case PartTooShort
//    case PartTooLong
//}
//
//func appendSpecial(value: String, part: String) throws -> String {
//    guard part.characters.count > 0 else {
//        throw ErrorSpecial.PartTooShort
//    }
//    guard part.characters.count < 10 else {
//        throw ErrorSpecial.PartTooLong
//    }
//    return value + part
//}
//
//do {
//    try appendSpecial("cat", part: "abc")
//} catch ErrorSpecial.PartTooShort {
//    print("Part was too short!")
//}


//enum DivErrors : ErrorType {
//    case Invalid
//}
//
//func divideBy(value: Int) throws -> Int {
//     guard value != 0 else {
//        throw DivErrors.Invalid
//    }
//    return 20 / value
//}
//
//
//let result = try? divideBy(10)
//print(result)
//
//if let result2 = try? divideBy(0) {
//    print(result2)
//}


//Keyword (#)

//func checkVersion(){
//if #available(iOS 9, *) {
//    print("It's iOS 9")
//    return
//}
//}
//checkVersion()

//func TEST(){
//    print("Function: \(#function), line: \(#line), file \(#file), column \(#column)")
//}
//TEST()
//
//
//#if swift(>=2.2)
//    print("Running Swift 2.2 or later")
//#else
//    print("Running Swift 2.1 or earlier")
//#endif
//

//#if DEBUG
//    let a = 2
//    print("Debug enable")
//#else
//    print("Debug disable")
//    let a = 3
//#endif







