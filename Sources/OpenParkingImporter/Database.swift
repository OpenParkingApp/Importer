import PostgresNIO
import OpenParkingBase

class Database {
    private let connection: PostgresConnection

    init() throws {
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.connection = try PostgresConnection.connect(
            to: .makeAddressResolvingHost("localhost", port: 5432),
            on: eventLoop.next()
        ).wait()
        try self.connection.authenticate(username: "kilian", database: "openparking", password: "").wait()

        try self.setup()
    }

    private func setup() throws {
        // Set up basic db scheme (don't overwrite or error if it already exists)
    }

    func close() throws {
        try self.connection.close().wait()
    }

    func save(datasources: [Datasource]) {
        // TODO
    }
}

let schema = """
DO $$ BEGIN
    CREATE TYPE lot_state AS ENUM ('open', 'closed', 'no_data');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS data (
    id BIGSERIAL PRIMARY KEY,
    lot_id TEXT NOT NULL,
    available INTEGER NOT NULL,
    capacity INTEGER,
    state lot_state NOT NULL,
    timestamp_downloaded TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    timestamp_source TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS datasources (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    info_url TEXT NOT NULL,
    contributor TEXT,
    attribution_url TEXT,
    license TEXT,
);
"""
