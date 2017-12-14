//
//  Utils.swift
//  Nimble
//
//  Created by Mauro Gonzalez on 05/12/2017.
//

import Foundation

extension String {
	func toJson() -> [String: Any]? {
		if let data = self.data(using: .utf8) {
			do {
				return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
			} catch {
				print(error.localizedDescription)
			}
		}
		return nil
	}

    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String? {
        return self.removingPercentEncoding?.replacingOccurrences(of: "+", with: " ")
    }
    
}
