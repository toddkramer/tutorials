#!/usr/bin/env swift

import Foundation

struct ShellResult {

    let output: String
    let status: Int32

}

let isVerbose = CommandLine.arguments.contains("--verbose")

@discardableResult
func shell(_ arguments: String...) -> ShellResult {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = arguments
    let pipe = Pipe()
    task.standardOutput = pipe
    let outputHandler = pipe.fileHandleForReading
    outputHandler.waitForDataInBackgroundAndNotify()

    var output = ""
    var dataObserver: NSObjectProtocol!
    let notificationCenter = NotificationCenter.default
    let dataNotificationName = NSNotification.Name.NSFileHandleDataAvailable
    dataObserver = notificationCenter.addObserver(forName: dataNotificationName, object: outputHandler, queue: nil) {  notification in
        let data = outputHandler.availableData
        guard data.count > 0 else {
            notificationCenter.removeObserver(dataObserver)
            return
        }
        if let line = String(data: data, encoding: .utf8) {
            if isVerbose {
                print(line)
            }
            output = output + line + "\n"
        }
        outputHandler.waitForDataInBackgroundAndNotify()
    }

    task.launch()
    task.waitUntilExit()
    return ShellResult(output: output, status: task.terminationStatus)
}

let projectPath = CommandLine.arguments[1]
guard projectPath.contains("xcodeproj") else {
    print("Error: First argument must be an Xcode project path.")
    exit(0)
}
let scheme = CommandLine.arguments[2]
shell("xcodebuild", "-project", projectPath, "-scheme", scheme, "-derivedDataPath", scheme + "/", "-destination", "platform=iOS Simulator,OS=11.4,name=iPhone 7", "-enableCodeCoverage", "YES", "clean", "build", "test", "CODE_SIGN_IDENTITY=\"\"", "CODE_SIGNING_REQUIRED=NO")
