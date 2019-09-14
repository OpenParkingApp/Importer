import struct Foundation.TimeInterval
import class Foundation.Timer
import class Foundation.RunLoop
import OpenParkingBase

public class Importer {
    let datasources: [Datasource]
    let db: Database
    let runInterval: TimeInterval
    var timer: Timer?

    public init(interval: TimeInterval = 5*60) throws {
        self.runInterval = interval
        self.datasources = registeredDatasources()
        self.db = try Database()

        self.db.save(datasources: self.datasources)
    }

    public func stop() throws {
        self.timer?.invalidate()
        try self.db.close()
    }

    // MARK: - Run

    public func runIndefinitely() throws {
        self.timer = Timer.scheduledTimer(withTimeInterval: self.runInterval, repeats: true) { [weak self] _ in
            self?.collect()
        }
        timer?.fire()
        RunLoop.main.run(until: .distantFuture)
    }

    func collect() {
        // TODO: Set up cities in cities table
        for datasource in self.datasources {
            print(datasource.name)
            do {
                let data = try datasource.data()
                print("\(data.timestamp): \(data.lots.count)")
            } catch {
                if let error = error as? OpenParkingError {
                    print(error)
                } else {
                    print(error)
                }
            }
        }
    }
}
