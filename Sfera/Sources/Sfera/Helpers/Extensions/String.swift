//
//  String.swift
//  testSfera
//
//  Created by Artour Ilyasov on 09.12.2022.
//

extension String {
    mutating func formatting() {
        self = self.replacingOccurrences(of: "del: del,", with: Resources.empty)
        self = self.replacingOccurrences(of: "del: ,", with: Resources.empty)
        self = self.replacingOccurrences(of: ": del", with: Resources.empty)
        self = self.replacingOccurrences(of: ":  ,", with: Resources.empty)
        self = self.replacingOccurrences(of: ": ,", with: Resources.empty)
        self = self.replacingOccurrences(of: " ,", with: ",")
        while self.last == "\n" || self.last == "," {
            self.removeLast()
        }
    }
}
