//
//  CommentApi.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 8/14/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation
import WishKitShared

struct CommentApi: RequestCreatable {

    private static let baseUrl = "\(ProjectSettings.apiUrl)"

    private static var endpoint = URL(string: "\(baseUrl)/comment")

    // MARK: - URLRequests

    private static func createComment(
        _ request: CreateCommentRequest,
        userUUID uuid: UUID
    ) -> URLRequest? {
        guard var url = endpoint else { return nil }
        url.appendPathComponent("create")
        return createAuthedPOSTRequest(to: url, with: request, userUUID: uuid)
    }

    static func createComment(
        request: CreateCommentRequest,
        userUUID uuid: UUID
    ) async -> ApiResult<CommentResponse, ApiError> {
        guard let request = createComment(request, userUUID: uuid) else {
            return .failure(ApiError(reason: .couldNotCreateRequest))
        }

        return await Api.send(request: request)
    }
}

