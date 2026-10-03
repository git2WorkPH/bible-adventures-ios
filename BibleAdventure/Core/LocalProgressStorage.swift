import Foundation
import OSLog

/// Atomic local storage. Reading does not alter or remove damaged saves.
struct LocalProgressStorage: ProgressDataStoring {
    let url: URL

    static var application: LocalProgressStorage {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        return LocalProgressStorage(url: base.appendingPathComponent("BibleAdventure/progress.json"))
    }

    func load() -> Result<Data?, ProgressStorageError> {
        do { return .success(try Data(contentsOf: url)) }
        catch let error as NSError where error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError {
            return .success(nil)
        } catch { return .failure(.unavailable) }
    }

    func save(_ data: Data) -> Result<Void, ProgressStorageError> {
        do {
            try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
            try data.write(to: url, options: .atomic)
            return .success(())
        } catch { return .failure(.writeFailed) }
    }
}

struct SystemLogWriter: StructuredLogWriting {
    func write(_ event: StructuredLogEvent) {
        Logger(subsystem: "BibleAdventure", category: event.category.rawValue)
            .error("\(event.operation.rawValue, privacy: .public): \(event.code, privacy: .public)")
    }
}
