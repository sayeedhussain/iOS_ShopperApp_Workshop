enum HttpMethod {
     case GET, POST
}

struct HttpRequest {
    let method: HttpMethod
    let url: String
    let body: [String: String]?
    let headers: [String: String]?
}
