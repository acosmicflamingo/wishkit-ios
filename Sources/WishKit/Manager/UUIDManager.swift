//
//  UUIDManager.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 2/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

public struct UUIDManager {

    private static let slug = "wishkit"

    private static let userUUIDKey = "\(slug)-user-uuid"

    public static func store(uuid: UUID) {
        UserDefaults.standard.set(uuid.uuidString, forKey: userUUIDKey)
    }

    public static func getUUID() -> UUID {
        if
            let uuidString = UserDefaults.standard.string(forKey: userUUIDKey),
            let uuid = UUID(uuidString: uuidString)
        {
            return uuid
        }

        let uuid = UUID()

        store(uuid: uuid)

        return uuid
    }

    public static func deleteUUID() {
        UserDefaults.standard.removeObject(forKey: userUUIDKey)
    }

  public init() {}
}
