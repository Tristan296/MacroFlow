import Foundation
import UIKit

enum MapsProvider { case apple, google }

final class MapsService {
    static let shared = MapsService()
    private init() {}

    func openMaps(query: String, provider: MapsProvider) {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString: String
        switch provider {
        case .apple:
            urlString = "http://maps.apple.com/?q=\(encoded)"
        case .google:
            urlString = "comgooglemaps://?q=\(encoded)"
        }
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if provider == .google, let web = URL(string: "https://www.google.com/maps/search/?api=1&query=\(encoded)") {
            UIApplication.shared.open(web)
        }
    }
}