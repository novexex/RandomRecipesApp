//
//  String.swift
//  testSfera
//
//  Created by Artour Ilyasov on 09.12.2022.
//

import Foundation

extension String {
    mutating func formatting() {
        self = self.replacingOccurrences(of: "del: del,", with: "")
        self = self.replacingOccurrences(of: "del: ,", with: "")
        self = self.replacingOccurrences(of: ": del", with: "")
        self = self.replacingOccurrences(of: ":  ,", with: "")
        self = self.replacingOccurrences(of: ": ,", with: "")
        self = self.replacingOccurrences(of: " ,", with: ",")
        while self.last == "\n" || self.last == "," {
            self.removeLast()
        }
    }
}
