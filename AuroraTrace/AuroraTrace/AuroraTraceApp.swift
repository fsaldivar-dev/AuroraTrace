//
//  AuroraTraceApp.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct AuroraTraceApp: App {
    var body: some Scene {
        Window("AuroraTrace", id: "Home") {
            AnyView(HomeModule.build())
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct AuroraTraceMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        AuroraTraceVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct AuroraTraceVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Item.self,
    ]
}
