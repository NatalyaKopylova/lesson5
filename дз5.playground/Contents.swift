import Foundation

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - TrunkCar и SportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

protocol CarProtocol: class {
    var carBrand: String { get }
    var yearOfRelease: Int { get }
    var trunkVolume: Double { get }
    var engineRunning: Bool { get set }
    var windowsIsOpen: Bool { get set }
    var filledTrunkVolume: Double { get set }
    
    func startEngine()
    func stopEngine()
    func openWindows()
    func closeWindows()
    func fillTrunk(cargoVolume: Double)
    func emptyTrunk(cargoVolume: Double)
}

extension CarProtocol {
    func startEngine() {
        self.engineRunning = true
    }
    
    func stopEngine() {
        self.engineRunning = false
        
    }
    
    func openWindows() {
        self.windowsIsOpen = true
    }
    
    func closeWindows() {
        self.windowsIsOpen = false
    }
    
    func fillTrunk(cargoVolume: Double) {
        if cargoVolume <= (trunkVolume - filledTrunkVolume) {
            filledTrunkVolume += cargoVolume
            print("Багажник загружен: \(filledTrunkVolume) л")
        } else {
            print("Объем багажника не позволяет поместить весь груз. Заполненный объем: \(trunkVolume - filledTrunkVolume)")
        }
    }
    
    func emptyTrunk(cargoVolume: Double) {
        if cargoVolume > filledTrunkVolume {
            print("Недостаточное количество груза в багажнике")
        } else {
            filledTrunkVolume -= cargoVolume
            print("Багажник разгружен")
        }
    }
}

class TrunkCar: CarProtocol {
    // MARK: CarProtocol
    let carBrand: String
    let yearOfRelease: Int
    let trunkVolume: Double
    var engineRunning: Bool
    var windowsIsOpen: Bool
    var filledTrunkVolume: Double
    
    let axesCount: Int
    let bodyType: BodyType
    
    enum BodyType: String {
        case mixer = "бетономешалка"
        case garbageTruck = "мусоровоз"
        case trunk = "грузовик"
    }
    
    init(carBrand: String, yearOfRelease: Int, trunkVolume: Double, engineRunning: Bool, windowsIsOpen: Bool, filledTrunkVolume: Double, axesCount: Int, bodyType: BodyType) {
        self.axesCount = axesCount
        self.bodyType = bodyType
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.trunkVolume = trunkVolume
        self.engineRunning = engineRunning
        self.windowsIsOpen = windowsIsOpen
        self.filledTrunkVolume = filledTrunkVolume
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
       return """
                  ___________________
               Автомобиль марки \(carBrand),
               произведен в \(yearOfRelease) году,
               вместимость багажника: \(trunkVolume),
               положение окон: \(windowsIsOpen ? "открыты" : "закрыты"),
               состояние двигателя: \(engineRunning ? "запущен" : "заглушен"),
               заполненный объем багажника: \(filledTrunkVolume),
               количество осей: \(axesCount),
               тип кузова: \(bodyType.rawValue)
               """
    }
}

class SportCar: CarProtocol {
    // MARK: CarProtocol
    let carBrand: String
    let yearOfRelease: Int
    let trunkVolume: Double
    var engineRunning: Bool
    var windowsIsOpen: Bool
    var filledTrunkVolume: Double
    
    let maxSpeed: Double
    let engineType: EngineType
    
    enum EngineType: String {
        case internalCombustion = "двигатель внутреннего сгорания"
        case electro = "электродвигатель"
        case hybride = "гибридный двигатель"
    }
    
    init(carBrand: String, yearOfRelease: Int, trunkVolume: Double, engineRunning: Bool, windowsIsOpen: Bool, filledTrunkVolume: Double, maxSpeed: Double, engineType: EngineType) {
        self.maxSpeed = maxSpeed
        self.engineType = engineType
        
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.trunkVolume = trunkVolume
        self.engineRunning = engineRunning
        self.windowsIsOpen = windowsIsOpen
        self.filledTrunkVolume = filledTrunkVolume
    }
}
   
extension SportCar: CustomStringConvertible {
    var description: String {
       return """
                    ________________
               Автомобиль марки \(carBrand),
               произведен в \(yearOfRelease) году,
               вместимость багажника: \(trunkVolume),
               положение окон: \(windowsIsOpen ? "открыты" : "закрыты"),
               состояние двигателя: \(engineRunning ? "запущен" : "заглушен"),
               заполненный объем багажника: \(filledTrunkVolume),
               максимальная скорость: \(maxSpeed),
               тип двигателя: \(engineType.rawValue)
               """
    }
}

var ford = TrunkCar(carBrand: "ford",
                    yearOfRelease: 2020,
                    trunkVolume: 3000,
                    engineRunning: true,
                    windowsIsOpen: true,
                    filledTrunkVolume: 0,
                    axesCount: 4,
                    bodyType: .trunk)

ford.stopEngine()
ford.closeWindows()
print(ford)

var volvo = TrunkCar(carBrand: "volvo",
                     yearOfRelease: 2021,
                     trunkVolume: 1200,
                     engineRunning: false,
                     windowsIsOpen: false,
                     filledTrunkVolume: 0,
                     axesCount: 3,
                     bodyType: .mixer)

volvo.startEngine()
volvo.closeWindows()
print(volvo)
volvo.fillTrunk(cargoVolume: 1100)

var mazda = SportCar(carBrand: "mazda",
                     yearOfRelease: 2021,
                     trunkVolume: 500,
                     engineRunning: false,
                     windowsIsOpen: false,
                     filledTrunkVolume: 200,
                     maxSpeed: 320,
                     engineType: .internalCombustion)

mazda.stopEngine()
mazda.closeWindows()
print(mazda)
mazda.emptyTrunk(cargoVolume: 200)

var nissan = SportCar(carBrand: "nissan",
                      yearOfRelease: 2019,
                      trunkVolume: 400,
                      engineRunning: true,
                      windowsIsOpen: false,
                      filledTrunkVolume: 0,
                      maxSpeed: 300,
                      engineType: .electro)

nissan.stopEngine()
nissan.openWindows()
print(nissan)
