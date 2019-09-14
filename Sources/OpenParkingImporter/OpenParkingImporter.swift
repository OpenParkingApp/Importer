import Foundation
import OpenParkingBase

import OpenParkingDresden
import OpenParkingBasel
import OpenParkingDeutscheBahn

public class Importer {
    let datasources: [Datasource]

    public init() {
        let deutscheBahnAccessToken = ProcessInfo.processInfo.environment["DEUTSCHEBAHN_TOKEN"] ?? ""
        self.datasources = [
            Dresden(),
            Basel(),
            DeutscheBahn(accessToken: deutscheBahnAccessToken),
        ]
    }

    public func run() {
        for source in self.datasources {
            do {
                let data = try source.data()
                print("Found information on \(data.lots.count) lots from \(source.name).")
            } catch {
                print(error)
            }
        }
    }
}
