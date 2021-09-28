//
//  String.swift
//  Hero Hub
//
//  Created by Ronny on 28/09/21.
//

import UIKit

extension String {
    var emptyString: String {
        return ""
    }
    
    var imageURLFormat: String? {
        let endpoint = Endpoint().path
        let endpointURL = URL(string: endpoint)!
        if var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false) {
            let imagePath = self
            urlComponents.path = imagePath
            if let imageURL = urlComponents.url {
                return imageURL.absoluteString.removingPercentEncoding
            }
        }
        return nil
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
