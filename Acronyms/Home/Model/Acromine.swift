//
//  Acromine.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 23-05-21.
//

import Foundation

struct Acromine: Codable {
    let sf: String
    let lfs: [LongForm]

    struct LongForm: Codable {
        let lf: String
        let freq: Int
        let since: Int
        let vars: [Variation]

        struct Variation: Codable {
            let lf: String
            let freq: Int
            let since: Int
        }
    }
}
