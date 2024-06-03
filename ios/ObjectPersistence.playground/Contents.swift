import ObjectiveC
import Foundation


// Basic class that can serialize using NSCoding and/or Codable
class MockSerializable: NSObject, NSCoding, Codable {
    
    let nameData: Data
    let age: Int
    
    init(nameData: Data, age: Int) {
        self.nameData = nameData
        self.age = age
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nameData, forKey: "name")
        coder.encode(age, forKey: "age")
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: "name") as! Data
        let age = coder.decodeInteger(forKey: "age")
        self.init(nameData: name, age: age)
    }
}

let fileManager = FileManager.default

// Get the documents directory URL
let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
guard let documentsDirectory = urls.first else {
    fatalError("Could not find the documents directory")
}

// Create the file URL
let fileURL = documentsDirectory.appendingPathComponent("mockserializable2.bin")
let name = "Steven Pak"

if let nameData = name.data(using: .utf8) {
    let m1 = MockSerializable(nameData: nameData, age: 25)
    
    // serialize "MockSerializable" as NSKeyedArchiver
    let data = try NSKeyedArchiver.archivedData(withRootObject: m1, requiringSecureCoding: false)
    try data.write(to: fileURL)
    
    // serialize with JSONEncoder
    let jsonEncoder = JSONEncoder()
    let jsonData = try jsonEncoder.encode(m1)
    print(String(data: jsonData, encoding: .utf8)!)
    
    // serialize NSKeyedArchiver to "NSUserDefaults"
    UserDefaults.standard.set(data, forKey: "MyMockObject")
    UserDefaults.standard.set("asdf", forKey: "asdfaMyMockObject")
    
}
