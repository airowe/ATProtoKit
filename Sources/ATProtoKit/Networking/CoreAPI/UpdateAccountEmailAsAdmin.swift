//
//  UpdateAccountEmailAsAdmin.swift
//
//
//  Created by Christopher Jr Riley on 2024-03-02.
//

import Foundation

extension ATProtoKit {
    /// Updates the email address of a user account as an administrator.
    ///
    /// - Note: Many of the parameter's descriptions are taken directly from the AT Protocol's specification.
    ///
    public func updateAccountEmailAsAdmin(_ accountDID: String, email: String) async throws {
        guard let sessionURL = session.pdsURL,
              let requestURL = URL(string: "\(sessionURL)/xrpc/com.atproto.admin.queryModerationEvents") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let requestBody = AdminUpdateAccountEmail(accountDID: accountDID, email: email)

        do {
            let request = APIClientService.createRequest(forRequest: requestURL, andMethod: .post, acceptValue: nil, contentTypeValue: "application/json", authorizationValue: "Bearer \(session.accessToken)")
        } catch {
            throw error
        }
    }
}