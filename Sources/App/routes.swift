import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post("info") { req -> InfoResponse in
        let data = try req.content.syncDecode(InfoData.self)
        return InfoResponse(request: data)
        
    }
    
    router.get("date") { req -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        return dateFormatter.string(from: Date())
    }
    
    router.get("counter", Int.parameter) { req -> CountJSON in
        let count = try req.parameters.next(Int.self)
        return CountJSON(count: count)
    }
    
    router.post("user-info") { req -> String in
        let userInfo = try req.content.syncDecode(UserInfoData.self)
        return "Hello \(userInfo.name) your age is \(userInfo.age)"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct Counter: Content {
    let number: Int
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}

struct CountJSON: Content {
    let count: Int
}

struct UserInfoData: Content {
    let name: String
    let age: Int
}
