//
//  Networking.swift
//  GitMotor
//
//  Created by Eric García on 28/01/21.
//

import Foundation

import Apollo
import UIKit

class Network {
    static let shared = Network()
    let graphQLEndpoint = "https://api.github.com/graphql"


    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: self.graphQLEndpoint)!

        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()

        let provider = NetworkInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)

        // Remember to give the store you already created to the client so it
        // doesn't create one on its own
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    // Find a better way to store your token this is just an example
    let githubToken = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"]!

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {

        request.addHeader(name: "Authorization", value: "Bearer \(githubToken)")

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
