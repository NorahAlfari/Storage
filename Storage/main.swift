// Task 1: Define the `Item` Type Alias

// Create a type alias named `Item` which represents a `String`. This will be used as the base type for serialization.
typealias Item = String

// Task 2: Define the `Storable` Protocol
//--------------------------------------
// Create a protocol `Storable` with the following requirements:
// - A function `serialize() -> Item` that converts the conforming type to `Item`.
// - A static function `deserialize(from item: Item) -> Self?` that creates an instance of the conforming type from `Item`.

protocol Storable {
    func serialize() -> Item
    static func deserialize(from item: Item) -> Self?
}

// Task 3: Conform Basic Types to `Storable`
//----------------------------------------
// Make `Int`, `Double`, and `String` conform to the `Storable` protocol. Implement the required methods for each type.

extension Int: Storable {
    func serialize() -> Item {
        return Item(self)
    }

    static func deserialize(from item: Item) -> Self? {
        return Int(item)
    }
}

extension Double: Storable {
    func serialize() -> Item {
        return Item(self)
    }

    static func deserialize(from item: Item) -> Self? {
        return Double(item)
    }
}

extension String: Storable {
    func serialize() -> Item {
        return self
    }

    static func deserialize(from item: Item) -> Self? {
        return item
    }
}

// Task 4: Define the `Storage` Protocol
//-------------------------------------
// Create a protocol `Storage` with the following requirements:
// - A function `save<Value: Storable>(key: String, value: Value)`
// - A function `retrieve(key: String) -> Optional<Item>`
// - A function `remove(key: String)`

protocol Storage {
    func save<Value: Storable>(key: String, value: Value)
    func retrieve(key: String) -> Item?
    func remove(key: String)
}

// Task 5: Implement `Cache` and `Disk` Classes
//--------------------------------------------
// Create two classes `Cache` and `Disk`, both conforming to the `Storage` protocol. Implement the methods with simple storage mechanisms.

// Required
class Cache: Storage {
    var storage: [String: Item] = [:]

    func save<Value: Storable>(key: String, value: Value) {
        storage[key] = value.serialize()
    }

    func retrieve(key: String) -> Item? {
        return storage[key]
    }

    func remove(key: String) {
        storage.removeValue(forKey: key)
    }
}

// Optional
//class Disk: Storage {
//    // Your implementation here
//    // Hint: use FileManager as a vault/chest
//}

// Example Usage
let cache = Cache()
// let disk = Disk()  // Uncomment when Disk is implemented

cache.save(key: "testInt", value: 123)
// disk.save(key: "testString", value: "Hello")  // Uncomment when Disk is implemented

// Retrieve and use the stored values
let retrievedInt = cache.retrieve(key: "testInt")
let deserializedInt = Int.deserialize(from: retrievedInt!)
if let deserializedInt = deserializedInt {
    print("Retrieved Int: \(deserializedInt)")
}

// Uncomment when Disk is implemented
// let retrievedString = disk.retrieve(key: "testString")
// let deserializedString = String.deserialize(from: retrievedString!)
// if let deserializedString = deserializedString {
//     print("Retrieved String: \(deserializedString)")
// }
