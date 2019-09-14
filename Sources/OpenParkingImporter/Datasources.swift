import class Foundation.ProcessInfo
import OpenParkingBase

import OpenParkingDresden
import OpenParkingBasel
import OpenParkingDeutscheBahn

func registeredDatasources() -> [Datasource] {
    let deutscheBahnAccessToken = ProcessInfo.processInfo.environment["DEUTSCHEBAHN_TOKEN"] ?? ""
    return [
        Dresden(),
        Basel(),
        DeutscheBahn(accessToken: deutscheBahnAccessToken),
    ]
}
