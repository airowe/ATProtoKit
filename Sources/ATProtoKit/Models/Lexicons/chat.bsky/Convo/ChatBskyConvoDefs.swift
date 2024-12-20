//
//  ChatBskyConvoDefs.swift
//
//
//  Created by Christopher Jr Riley on 2024-05-19.
//

import Foundation

extension ChatBskyLexicon.Conversation {

    /// A definition model for a message reference.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct MessageReferenceDefinition: Sendable, Codable {

        /// The decentralized identifier (DID) of the message.
        public let messageDID: String

        /// The ID of the message.
        public let messageID: String

        /// The ID of the conversation.
        public let conversationID: String

        enum CodingKeys: String, CodingKey {
            case messageDID = "did"
            case messageID = "messageId"
            case conversationID = "convoId"
        }
    }

    /// A definition model for a message.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct MessageInputDefinition: Sendable, Codable {

        /// The message text itself.
        ///
        /// - Important: Current maximum length is 1,000 characters.
        public let text: String

        /// An array of facets contained in the message's text. Optional.
        ///
        /// - Note: According to the AT Protocol specifications: "Annotations of text (mentions,
        /// URLs, hashtags, etc)"
        public let facets: [AppBskyLexicon.RichText.Facet]?

        /// An array of embeds for the message. Optional.
        public let embeds: [ATUnion.MessageInputEmbedUnion]?

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            // Truncate `tags` to 10000 characters before encoding
            // `maxGraphemes`'s limit is 1000, but `String.count` should respect that limit implictly
            try truncatedEncode(self.text, withContainer: &container, forKey: .text, upToCharacterLength: 1_000)
            try container.encodeIfPresent(self.facets, forKey: .facets)
            try container.encodeIfPresent(self.embeds, forKey: .embeds)
        }

        enum CodingKeys: String, CodingKey {
            case text
            case facets
            case embeds = "embed"
        }
    }

    /// A definition model for a message view.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct MessageViewDefinition: Sendable, Codable {

        /// The ID of the message. Optional.
        public let messageID: String?

        /// The revision of the message.
        public let revision: String

        /// The message text itself.
        ///
        /// - Important: Current maximum length is 1,000 characters.
        public let text: String

        /// An array of facets contained in the message's text. Optional.
        ///
        /// - Note: According to the AT Protocol specifications: "Annotations of text (mentions,
        /// URLs, hashtags, etc)"
        public let facets: [AppBskyLexicon.RichText.Facet]?

        /// An array of embeds for the message. Optional.
        public let embeds: [ATUnion.MessageViewEmbedUnion]?

        /// The sender of the message.
        public let sender: String

        /// The date and time the message was seen.
        @DateFormatting public var seenAt: Date

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encodeIfPresent(self.messageID, forKey: .messageID)
            try container.encode(self.revision, forKey: .revision)
            // Truncate `tags` to 10000 characters before encoding
            // `maxGraphemes`'s limit is 1000, but `String.count` should respect that limit implictly
            try truncatedEncode(self.text, withContainer: &container, forKey: .text, upToCharacterLength: 1_000)
            try container.encodeIfPresent(self.facets, forKey: .facets)
            try container.encodeIfPresent(self.embeds, forKey: .embeds)
            try container.encode(self.sender, forKey: .sender)
            try container.encode(self._seenAt, forKey: .seenAt)
        }

        public enum CodingKeys: String, CodingKey {
            case messageID = "id"
            case revision = "rev"
            case text
            case facets
            case embeds = "embed"
            case sender
            case seenAt
        }
    }

    /// A definition model for a deleted message view.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct DeletedMessageViewDefinition: Sendable, Codable {

        /// The ID of the message. Optional.
        public let messageID: String?

        /// The revision of the message.
        public let revision: String

        /// The sender of the message.
        public let sender: String

        /// The date and time the message was seen.
        @DateFormatting public var seenAt: Date

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encodeIfPresent(self.messageID, forKey: .messageID)
            try container.encode(self.revision, forKey: .revision)
            try container.encode(self.sender, forKey: .sender)
            try container.encode(self._seenAt, forKey: .seenAt)
        }

        enum CodingKeys: String, CodingKey {
            case messageID = "id"
            case revision = "rev"
            case sender
            case seenAt
        }
    }

    /// A definition model for the message view's sender.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct MessageViewSenderDefinition: Sendable, Codable {

        /// The decentralized identifier (DID) of the message.
        public let messageDID: String

        enum CodingKeys: String, CodingKey {
            case messageDID = "did"
        }
    }

    /// A definition model for a conversation view.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct ConversationViewDefinition: Sendable, Codable {

        /// The ID of the conversation.
        public let conversationID: String

        /// The revision of the conversation.
        public let revision: String

        /// An array of basic profile views within the conversation.
        public let members: [ChatBskyLexicon.Actor.ProfileViewBasicDefinition]

        /// The last message in the conversation. Optional.
        public let lastMessage: ATUnion.ConversationViewLastMessageUnion?

        /// Indicates whether the conversation is muted.
        public let isMuted: Bool

        /// The number of messages that haven't been read.
        public let unreadCount: Int

        enum CodingKeys: String, CodingKey {
            case conversationID = "id"
            case revision = "rev"
            case members
            case lastMessage
            case isMuted = "muted"
            case unreadCount
        }
    }

    /// A definition model for a log for beginning the coversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct LogBeginConversationDefinition: Sendable, Codable {

        /// The revision of the log.
        public let revision: String

        /// The ID of the conversation.
        public let conversationID: String

        enum CodingKeys: String, CodingKey {
            case revision = "rev"
            case conversationID = "convoID"
        }
    }

    /// A definition model for a log for leaving the conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct LogLeaveConversationDefinition: Sendable, Codable {

        /// The revision of the log.
        public let revision: String

        /// The ID of the conversation.
        public let conversationID: String

        enum CodingKeys: String, CodingKey {
            case revision = "rev"
            case conversationID = "convoID"
        }
    }

    /// A definition model for a log for creating a message.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct LogCreateMessageDefinition: Sendable, Codable {

        /// The revision of the log.
        public let revision: String

        /// The ID of the conversation.
        public let conversationID: String

        /// The message itself.
        public let message: ATUnion.LogCreateMessageUnion

        enum CodingKeys: String, CodingKey {
            case revision = "rev"
            case conversationID = "convoID"
            case message
        }
    }

    /// A definition model for a log for deleting a message.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.defs`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/defs.json
    public struct LogDeleteMessageDefinition: Sendable, Codable {

        /// The revision of the log.
        public let revision: String

        /// The ID of the conversation.
        public let conversationID: String

        /// The message itself.
        public let message: ATUnion.LogDeleteMessageUnion

        enum CodingKeys: String, CodingKey {
            case revision = "rev"
            case conversationID = "convoID"
            case message
        }
    }
}
