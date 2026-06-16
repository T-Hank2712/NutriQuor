//
//  ScanHistoryManager.swift
//  NutriQuor
//

import Foundation

final class ScanHistoryManager {

    static let shared = ScanHistoryManager()

    private init() {}

    private func key(for userId: String) -> String {
        "scan_history_\(userId)"
    }

    // MARK: - Save
    func save(product: Product, userId: String) {
        var histories = getAll(userId: userId)

        let item = ScanHistory(
            id: UUID(),
            scannedAt: Date(),
            product: product
        )
        histories.insert(item, at: 0)

        if histories.count > 100 {
            histories.removeLast()
        }
        save(histories, userId: userId)
    }

    // MARK: - Get
    func getAll(userId: String) -> [ScanHistory] {
        guard let data = UserDefaults.standard.data(forKey: key(for: userId)),
              let histories = try? JSONDecoder().decode([ScanHistory].self, from: data)
        else {
            return []
        }

        return Array(histories.prefix(100))
    }

    // MARK: - Delete
    func delete(id: UUID, userId: String) {
        var histories = getAll(userId: userId)

        histories.removeAll { $0.id == id }

        save(histories, userId: userId)
    }

    // MARK: - Clear per user
    func clear(userId: String) {
        UserDefaults.standard.removeObject(forKey: key(for: userId))
    }

    // MARK: - Private save helper
    private func save(_ histories: [ScanHistory], userId: String) {
        if let data = try? JSONEncoder().encode(histories) {
            UserDefaults.standard.set(data, forKey: key(for: userId))
        }
    }
}
