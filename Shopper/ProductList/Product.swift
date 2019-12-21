struct Product: Codable, Equatable {
    let pid: String
    let name: String
    let price: String
    let offerPrice: String?
    let desc: String?
    let image: String
}

func == (obj1 : Product, obj2 : Product) -> Bool {
    return obj1.pid == obj2.pid
}
