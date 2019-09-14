import Foundation
import OpenParkingImporter

let importer = try Importer()

defer {
    try! importer.stop()
}

signal(SIGINT) { _ in
    try! importer.stop()
    exit(1)
}

try importer.runIndefinitely()
