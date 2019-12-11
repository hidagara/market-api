import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Store: Codable {
    /// The unique identifier for this `Store`.
    var id: Int?

    /// A title describing what this `Store` entails.
    var title: String

    /// Creates a new `Store`.
    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
//
//extension Store: Model {
//    typealias Database = SQLiteDatabase
//
//    typealias ID = Int
//
//    static let idKey: IDKey = \Store.id
//
//
//}

extension Store: SQLiteModel {}
extension Store: Content {}
extension Store: Migration {}
