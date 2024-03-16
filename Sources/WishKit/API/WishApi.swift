//
//  WishApi.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 2/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation
import WishKitShared

public struct WishApi: RequestCreatable {

    private static let baseUrl = "\(ProjectSettings.apiUrl)"

    private static var endpoint = URL(string: "\(baseUrl)/wish")

    // MARK: - URLRequests

    private static func fetchWishList(
      userUUID uuid: UUID
    ) -> URLRequest? {
        guard var url = endpoint else { return nil }
        url.appendPathComponent("list")
        return createAuthedGETRequest(to: url, userUUID: uuid)
    }

    private static func createWish(
      _ createRequest: CreateWishRequest,
      userUUID uuid: UUID
    ) -> URLRequest? {
        guard var url = endpoint else { return nil }
        url.appendPathComponent("create")
        return createAuthedPOSTRequest(to: url, with: createRequest, userUUID: uuid)
    }

    private static func voteWish(
      _ voteRequest: VoteWishRequest,
      userUUID uuid: UUID
    ) -> URLRequest? {
        guard var url = endpoint else { return nil }
        url.appendPathComponent("vote")
        return createAuthedPOSTRequest(to: url, with: voteRequest, userUUID: uuid)
    }

    // MARK: - Api Requests

    public static func fetchWishList(
        userUUID uuid: UUID? = nil
    ) async -> ApiResult<ListWishResponse, ApiError> {
        let uuid = uuid ?? UUIDManager.getUUID()
        return await withCheckedContinuation { continuation in
            fetchWishList(userUUID: uuid) { completion in
                continuation.resume(returning: completion)
            }
        }
    }

    public static func fetchWishList(
        userUUID uuid: UUID? = nil,
        completionHandler: @escaping (ApiResult<ListWishResponse, ApiError>) -> Void
    ) {
        let uuid = uuid ?? UUIDManager.getUUID()
        guard let request = fetchWishList(userUUID: uuid) else {
            completionHandler(.failure(ApiError(reason: .couldNotCreateRequest)))
            return
        }

        Api.send(request: request, completionHandler: completionHandler)
    }

    public static func createWish(
        createRequest: CreateWishRequest,
        userUUID uuid: UUID? = nil
    ) async -> ApiResult<CreateWishResponse, ApiError> {
        let uuid = uuid ?? UUIDManager.getUUID()
        return await withCheckedContinuation { continuation in
            createWish(createRequest: createRequest, userUUID: uuid) { completion in
                continuation.resume(returning: completion)
            }
        }
    }

    public static func createWish(
        createRequest: CreateWishRequest,
        userUUID uuid: UUID? = nil,
        completionHandler: @escaping (ApiResult<CreateWishResponse, ApiError>) -> Void
    ) {
        let uuid = uuid ?? UUIDManager.getUUID()
        guard let request = createWish(createRequest, userUUID: uuid) else {
            completionHandler(.failure(ApiError(reason: .couldNotCreateRequest)))
            return
        }

        Api.send(request: request, completionHandler: completionHandler)
    }

    public static func voteWish(
        voteRequest: VoteWishRequest,
        userUUID uuid: UUID? = nil
    ) async -> ApiResult<VoteWishResponse, ApiError> {
        let uuid = uuid ?? UUIDManager.getUUID()
        return await withCheckedContinuation { continuation in
            voteWish(voteRequest: voteRequest, userUUID: uuid) { completion in
                continuation.resume(returning: completion)
            }
        }
    }

    public static func voteWish(
        voteRequest: VoteWishRequest,
        userUUID uuid: UUID? = nil,
        completionHandler: @escaping (ApiResult<VoteWishResponse, ApiError>) -> Void
    ) {
        let uuid = uuid ?? UUIDManager.getUUID()
        guard let request = voteWish(voteRequest, userUUID: uuid) else {
            completionHandler(.failure(ApiError(reason: .couldNotCreateRequest)))
            return
        }

        Api.send(request: request, completionHandler: completionHandler)
    }
}
