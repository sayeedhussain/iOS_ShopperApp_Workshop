import Foundation

protocol KeyValueStore {
    
    func setValue<T:Codable>(value: T, forKey: String) -> Bool
    
    func value<T:Codable>(for key: String) -> T?
    
}

class KeyValueStoreImpl: KeyValueStore {
    
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(userDefaults: UserDefaults = UserDefaults.standard,
         encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func setValue<T>(value: T, forKey key: String) -> Bool where T : Decodable, T : Encodable {
        guard let data = try? encoder.encode(value) else {
            return false
        }
        userDefaults.setValue(data, forKey: key)
        return true
    }
    
    func value<T>(for key: String) -> T? where T : Decodable, T : Encodable {
        
        guard let value = userDefaults.value(forKey: key) else {
            return nil
        }
        
        guard let valueAsData = value as? Data else {
            return nil
        }

        guard let data = try? decoder.decode(T.self, from: valueAsData) else {
            return nil
        }
        
        return data
    }
    
}

