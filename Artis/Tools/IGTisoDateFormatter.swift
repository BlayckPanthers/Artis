//
//  IGTisoDateFormatter.swift
//  InstaTrainingSwiftUI
//
//  Created by Fabien Lebon on 19/10/2020.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}

extension String {
    var iso8601: Date? { return Formatter.iso8601.date(from: self) }
}

extension Date {
    func formatdate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
}
