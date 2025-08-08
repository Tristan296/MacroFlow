import Foundation

struct FlightOption: Identifiable, Codable, Hashable {
    let id = UUID()
    let airline: String
    let priceUSD: Double
    let departTime: Date
    let arriveTime: Date
    let origin: String
    let destination: String
}

final class FlightService {
    static let shared = FlightService()
    private init() {}

    enum Provider { case amadeus, kiwi }

    func searchFlights(origin: String, destination: String, departDate: Date, returnDate: Date?) async throws -> [FlightOption] {
        // If you have keys, implement provider call below; otherwise, return mock data
        if ProcessInfo.processInfo.environment["AMADEUS_API_KEY"] != nil {
            // TODO: implement
        }
        // Mock
        let dep1 = departDate.addingTimeInterval(9 * 3600)
        let arr1 = dep1.addingTimeInterval(11 * 3600)
        var results = [FlightOption(airline: "Example Air", priceUSD: 799, departTime: dep1, arriveTime: arr1, origin: origin, destination: destination)]
        if let returnDate = returnDate {
            let dep2 = returnDate.addingTimeInterval(10 * 3600)
            let arr2 = dep2.addingTimeInterval(12 * 3600)
            results.append(FlightOption(airline: "Example Air", priceUSD: 820, departTime: dep2, arriveTime: arr2, origin: destination, destination: origin))
        }
        return results
    }
}