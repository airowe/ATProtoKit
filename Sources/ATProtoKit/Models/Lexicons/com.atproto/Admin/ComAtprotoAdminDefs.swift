//
//  ComAtprotoAdminDefs.swift
//
//
//  Created by Christopher Jr Riley on 2024-05-20.
//

import Foundation

extension ComAtprotoLexicon.Admin {

    /// A definition model for admin status attributes.
    ///
    /// - SeeAlso: This is based on the [`com.atproto.admin.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/admin/defs.json
    public struct StatusAttributesDefinition: Sendable, Codable {

        /// Indicates whether the status attributes are being applied.
        public let isApplied: Bool

        /// The reference of the attributes.
        public let reference: String?

        enum CodingKeys: String, CodingKey {
            case isApplied = "applied"
            case reference = "ref"
        }
    }

    /// A definition model for an account view.
    ///
    /// - SeeAlso: This is based on the [`com.atproto.admin.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/admin/defs.json
    public struct AccountViewDefinition: Sendable, Codable {

        /// The decentralized identifier (DID) of the user.
        public let actorDID: String

        /// The handle of the user.
        public let handle: String

        /// The email of the user. Optional.
        public var email: String?

        /// The user's related records. Optional.
        ///
        /// - Important: The item associated with this property is undocumented in the AT Protocol specifications. The documentation here is based on:\
        ///   \* **For items with some inferable context from property names or references**: its best interpretation, though not with full certainty.\
        ///   \* **For items without enough context for even an educated guess**: a direct acknowledgment of their undocumented status.\
        ///   \
        ///   Clarifications from Bluesky are needed in order to fully understand this item.
        public var relatedRecords: [UnknownType]?

        /// The date and time the user was last indexed.
        @DateFormatting public var indexedAt: Date

        /// The invite code used by the user to sign up. Optional.
        public var invitedBy: ComAtprotoLexicon.Server.InviteCodeDefinition?

        /// An array of invite codes held by the user. Optional.
        public var invites: [ComAtprotoLexicon.Server.InviteCodeDefinition]?

        /// Indicates whether the invite codes held by the user are diabled. Optional.
        public var areInvitesDisabled: Bool?

        /// The date and time the email of the user was confirmed. Optional.
        @DateFormattingOptional public var emailConfirmedAt: Date?

        /// Any notes related to inviting the user. Optional.
        public var inviteNote: String?

        /// The date and time a status has been deactivated.
        @DateFormattingOptional public var deactivatedAt: Date?

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(self.actorDID, forKey: .actorDID)
            try container.encode(self.handle, forKey: .handle)
            try container.encodeIfPresent(self.email, forKey: .email)
            try container.encodeIfPresent(self.relatedRecords, forKey: .relatedRecords)
            try container.encode(self._indexedAt, forKey: .indexedAt)
            try container.encodeIfPresent(self.invitedBy, forKey: .invitedBy)
            try container.encodeIfPresent(self.invites, forKey: .invites)
            try container.encodeIfPresent(self.areInvitesDisabled, forKey: .areInvitesDisabled)
            try container.encode(self._emailConfirmedAt, forKey: .emailConfirmedAt)
            try container.encodeIfPresent(self.inviteNote, forKey: .inviteNote)
            try container.encodeIfPresent(self._deactivatedAt, forKey: .deactivatedAt)
        }

        enum CodingKeys: String, CodingKey {
            case actorDID = "did"
            case handle
            case email
            case relatedRecords
            case indexedAt
            case invitedBy
            case invites
            case areInvitesDisabled = "invitesDisabled"
            case emailConfirmedAt
            case inviteNote
            case deactivatedAt
        }
    }

    /// A definition model for a repository reference.
    ///
    /// - SeeAlso: This is based on the [`com.atproto.admin.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/admin/defs.json
    public struct RepositoryReferenceDefinition: Sendable, Codable {

        /// The decentralized identifier (DID) of the repository.
        public let repositoryDID: String

        enum CodingKeys: String, CodingKey {
            case repositoryDID = "did"
        }
    }

    /// A definition model for a blob reference.
    ///
    /// - SeeAlso: This is based on the [`com.atproto.admin.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/admin/defs.json
    public struct RepositoryBlobReferenceDefinition: Sendable, Codable {

        /// The decentralized identifier (DID) of the blob reference.
        public let blobDID: String

        /// The CID hash of the blob reference.
        public let cidHash: String

        /// The URI of the record that contains the blob reference.
        public let recordURI: String?

        enum CodingKeys: String, CodingKey {
            case blobDID = "did"
            case cidHash = "cid"
            case recordURI = "recordUri"
        }
    }
}
