//
//  ComAtprotoServerCreateAppPassword.swift
//
//
//  Created by Christopher Jr Riley on 2024-05-20.
//

import Foundation

extension ComAtprotoLexicon.Server {
    
    /// The request body data model definition for creating an App Password.
    ///
    /// - Note: According to the AT Protocol specifications: "Create an App Password."
    ///
    /// - SeeAlso: This is based on the [`com.atproto.server.createAppPassword`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/server/createAppPassword.json
    public struct CreateAppPasswordRequestBody: Codable {

        /// The name given to the App Password to help distingush it from others.
        ///
        /// - Note: According to the AT Protocol specifications: "A short name for the
        /// App Password, to help distinguish them."
        public let name: String
    }

    /// A data model definition for creating an App Password.
    ///
    /// - Note: According to the AT Protocol specifications: "Create an App Password."
    ///
    /// - SeeAlso: This is based on the [`com.atproto.server.createAppPassword`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/server/createAppPassword.json
    public struct CreateAppPasswordOutput: Codable {

        /// The name given to the App Password to help distingush it from others.
        ///
        /// - Note: According to the AT Protocol specifications: "A short name for the
        /// App Password, to help distinguish them."
        public let name: String

        /// The password itself.
        public let password: String

        /// The date and time the App Password was created.
        @DateFormatting public var createdAt: Date

        public init(name: String, password: String, createdAt: Date) {
            self.name = name
            self.password = password
            self._createdAt = DateFormatting(wrappedValue: createdAt)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.name = try container.decode(String.self, forKey: .name)
            self.password = try container.decode(String.self, forKey: .password)
            self.createdAt = try container.decode(DateFormatting.self.self, forKey: .createdAt).wrappedValue
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(self.name, forKey: .name)
            try container.encode(self.password, forKey: .password)
            try container.encode(self._createdAt, forKey: .createdAt)
        }

        enum CodingKeys: CodingKey {
            case name
            case password
            case createdAt
        }
    }
}
