#!/usr/bin/env swift

import Foundation

struct CoverageReport: Codable {

    let lines: Int
    let coverage: Double

    private enum CodingKeys: String, CodingKey {
        case lines = "coveredLines"
        case coverage = "lineCoverage"
    }

}

let arguments = CommandLine.arguments
guard arguments.count == 2 else {
    print("Error: Invalid arguments.")
    exit(0)
}
let file = CommandLine.arguments[1]
let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = currentDirectoryPath + "/" + file
guard let json = try? String(contentsOfFile: filePath, encoding: .utf8), let data = json.data(using: .utf8) else {
    print("Error: Invalid JSON")
    exit(0)
}
guard let report = try? JSONDecoder().decode(CoverageReport.self, from: data) else {
    print("Error: Could not decode the report.")
    exit(0)
}

let percentFormatter = NumberFormatter()
percentFormatter.numberStyle = NumberFormatter.Style.percent
percentFormatter.minimumFractionDigits = 1
percentFormatter.maximumFractionDigits = 2
guard let coveragePercent = percentFormatter.string(from: NSNumber(value: report.coverage)) else {
    print("Error: Could not generate code coverage percentage.")
    exit(0)
}
print("\(coveragePercent) code coverage based on \(report.lines) lines.")
