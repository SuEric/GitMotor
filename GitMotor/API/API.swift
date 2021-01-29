// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The possible states of an issue.
public enum IssueState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// An issue that is still open
  case `open`
  /// An issue that has been closed
  case closed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "CLOSED": self = .closed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .closed: return "CLOSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: IssueState, rhs: IssueState) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.closed, .closed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [IssueState] {
    return [
      .open,
      .closed,
    ]
  }
}

/// The possible states of a subscription.
public enum SubscriptionState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The User is only notified when participating or @mentioned.
  case unsubscribed
  /// The User is notified of all conversations.
  case subscribed
  /// The User is never notified.
  case ignored
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "UNSUBSCRIBED": self = .unsubscribed
      case "SUBSCRIBED": self = .subscribed
      case "IGNORED": self = .ignored
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .unsubscribed: return "UNSUBSCRIBED"
      case .subscribed: return "SUBSCRIBED"
      case .ignored: return "IGNORED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: SubscriptionState, rhs: SubscriptionState) -> Bool {
    switch (lhs, rhs) {
      case (.unsubscribed, .unsubscribed): return true
      case (.subscribed, .subscribed): return true
      case (.ignored, .ignored): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [SubscriptionState] {
    return [
      .unsubscribed,
      .subscribed,
      .ignored,
    ]
  }
}

public final class RepositoryCommitsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoryCommits($repositoryOwner: String!, $repositoryName: String!) {
      repository(owner: $repositoryOwner, name: $repositoryName) {
        __typename
        object(expression: "master") {
          __typename
          ... on Commit {
            history(first: 20) {
              __typename
              nodes {
                __typename
                ...CommitSummary
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoryCommits"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + CommitSummary.fragmentDefinition)
    document.append("\n" + AuthorSummary.fragmentDefinition)
    return document
  }

  public var repositoryOwner: String
  public var repositoryName: String

  public init(repositoryOwner: String, repositoryName: String) {
    self.repositoryOwner = repositoryOwner
    self.repositoryName = repositoryName
  }

  public var variables: GraphQLMap? {
    return ["repositoryOwner": repositoryOwner, "repositoryName": repositoryName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("repositoryOwner"), "name": GraphQLVariable("repositoryName")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("object", arguments: ["expression": "master"], type: .object(Object.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(object: Object? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "object": object.flatMap { (value: Object) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A Git object in the repository
      public var object: Object? {
        get {
          return (resultMap["object"] as? ResultMap).flatMap { Object(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "object")
        }
      }

      public struct Object: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Commit", "Tree", "Blob", "Tag"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLTypeCase(
              variants: ["Commit": AsCommit.selections],
              default: [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              ]
            )
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTree() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tree"])
        }

        public static func makeBlob() -> Object {
          return Object(unsafeResultMap: ["__typename": "Blob"])
        }

        public static func makeTag() -> Object {
          return Object(unsafeResultMap: ["__typename": "Tag"])
        }

        public static func makeCommit(history: AsCommit.History) -> Object {
          return Object(unsafeResultMap: ["__typename": "Commit", "history": history.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asCommit: AsCommit? {
          get {
            if !AsCommit.possibleTypes.contains(__typename) { return nil }
            return AsCommit(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsCommit: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Commit"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("history", arguments: ["first": 20], type: .nonNull(.object(History.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(history: History) {
            self.init(unsafeResultMap: ["__typename": "Commit", "history": history.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The linear commit history starting from (and including) this commit, in the same order as `git log`.
          public var history: History {
            get {
              return History(unsafeResultMap: resultMap["history"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "history")
            }
          }

          public struct History: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["CommitHistoryConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "CommitHistoryConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Commit"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(CommitSummary.self),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var commitSummary: CommitSummary {
                  get {
                    return CommitSummary(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoryReleasesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoryReleases($repositoryOwner: String!, $repositoryName: String!) {
      repository(owner: $repositoryOwner, name: $repositoryName) {
        __typename
        releases(first: 20) {
          __typename
          nodes {
            __typename
            ...ReleaseSummary
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoryReleases"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + ReleaseSummary.fragmentDefinition)
    document.append("\n" + AuthorInfo.fragmentDefinition)
    return document
  }

  public var repositoryOwner: String
  public var repositoryName: String

  public init(repositoryOwner: String, repositoryName: String) {
    self.repositoryOwner = repositoryOwner
    self.repositoryName = repositoryName
  }

  public var variables: GraphQLMap? {
    return ["repositoryOwner": repositoryOwner, "repositoryName": repositoryName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("repositoryOwner"), "name": GraphQLVariable("repositoryName")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("releases", arguments: ["first": 20], type: .nonNull(.object(Release.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(releases: Release) {
        self.init(unsafeResultMap: ["__typename": "Repository", "releases": releases.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// List of releases which are dependent on this repository.
      public var releases: Release {
        get {
          return Release(unsafeResultMap: resultMap["releases"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "releases")
        }
      }

      public struct Release: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ReleaseConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ReleaseConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Release"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ReleaseSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var releaseSummary: ReleaseSummary {
              get {
                return ReleaseSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoryCollaboratorsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoryCollaborators($repositoryOwner: String!, $repositoryName: String!) {
      repository(owner: $repositoryOwner, name: $repositoryName) {
        __typename
        collaborators(first: 20) {
          __typename
          nodes {
            __typename
            ...AuthorInfo
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoryCollaborators"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + AuthorInfo.fragmentDefinition)
    return document
  }

  public var repositoryOwner: String
  public var repositoryName: String

  public init(repositoryOwner: String, repositoryName: String) {
    self.repositoryOwner = repositoryOwner
    self.repositoryName = repositoryName
  }

  public var variables: GraphQLMap? {
    return ["repositoryOwner": repositoryOwner, "repositoryName": repositoryName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("repositoryOwner"), "name": GraphQLVariable("repositoryName")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("collaborators", arguments: ["first": 20], type: .object(Collaborator.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(collaborators: Collaborator? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "collaborators": collaborators.flatMap { (value: Collaborator) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of collaborators associated with the repository.
      public var collaborators: Collaborator? {
        get {
          return (resultMap["collaborators"] as? ResultMap).flatMap { Collaborator(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "collaborators")
        }
      }

      public struct Collaborator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryCollaboratorConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryCollaboratorConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(AuthorInfo.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatarUrl: String, name: String? = nil, email: String) {
            self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "email": email])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var authorInfo: AuthorInfo {
              get {
                return AuthorInfo(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoryIssuesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoryIssues($repositoryOwner: String!, $repositoryName: String!) {
      repository(owner: $repositoryOwner, name: $repositoryName) {
        __typename
        openIssues: issues(last: 20, states: OPEN) {
          __typename
          nodes {
            __typename
            ...IssueSummary
          }
        }
        closedIssues: issues(last: 20, states: CLOSED) {
          __typename
          nodes {
            __typename
            ...IssueSummary
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoryIssues"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + IssueSummary.fragmentDefinition)
    document.append("\n" + IssueAuthor.fragmentDefinition)
    return document
  }

  public var repositoryOwner: String
  public var repositoryName: String

  public init(repositoryOwner: String, repositoryName: String) {
    self.repositoryOwner = repositoryOwner
    self.repositoryName = repositoryName
  }

  public var variables: GraphQLMap? {
    return ["repositoryOwner": repositoryOwner, "repositoryName": repositoryName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("repositoryOwner"), "name": GraphQLVariable("repositoryName")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("issues", alias: "openIssues", arguments: ["last": 20, "states": "OPEN"], type: .nonNull(.object(OpenIssue.selections))),
          GraphQLField("issues", alias: "closedIssues", arguments: ["last": 20, "states": "CLOSED"], type: .nonNull(.object(ClosedIssue.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(openIssues: OpenIssue, closedIssues: ClosedIssue) {
        self.init(unsafeResultMap: ["__typename": "Repository", "openIssues": openIssues.resultMap, "closedIssues": closedIssues.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of issues that have been opened in the repository.
      public var openIssues: OpenIssue {
        get {
          return OpenIssue(unsafeResultMap: resultMap["openIssues"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "openIssues")
        }
      }

      /// A list of issues that have been opened in the repository.
      public var closedIssues: ClosedIssue {
        get {
          return ClosedIssue(unsafeResultMap: resultMap["closedIssues"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "closedIssues")
        }
      }

      public struct OpenIssue: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["IssueConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "IssueConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Issue"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(IssueSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var issueSummary: IssueSummary {
              get {
                return IssueSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

      public struct ClosedIssue: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["IssueConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "IssueConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Issue"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(IssueSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var issueSummary: IssueSummary {
              get {
                return IssueSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoryPullRequestsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoryPullRequests($repositoryOwner: String!, $repositoryName: String!) {
      repository(owner: $repositoryOwner, name: $repositoryName) {
        __typename
        openPullRequests: pullRequests(first: 20, states: OPEN) {
          __typename
          nodes {
            __typename
            ...PullRequestSummary
          }
        }
        mergedPullRequests: pullRequests(first: 20, states: MERGED) {
          __typename
          nodes {
            __typename
            ...PullRequestSummary
          }
        }
        closedPullRequests: pullRequests(first: 20, states: CLOSED) {
          __typename
          nodes {
            __typename
            ...PullRequestSummary
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoryPullRequests"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + PullRequestSummary.fragmentDefinition)
    document.append("\n" + PullRequestAuthor.fragmentDefinition)
    return document
  }

  public var repositoryOwner: String
  public var repositoryName: String

  public init(repositoryOwner: String, repositoryName: String) {
    self.repositoryOwner = repositoryOwner
    self.repositoryName = repositoryName
  }

  public var variables: GraphQLMap? {
    return ["repositoryOwner": repositoryOwner, "repositoryName": repositoryName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("repository", arguments: ["owner": GraphQLVariable("repositoryOwner"), "name": GraphQLVariable("repositoryName")], type: .object(Repository.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequests", alias: "openPullRequests", arguments: ["first": 20, "states": "OPEN"], type: .nonNull(.object(OpenPullRequest.selections))),
          GraphQLField("pullRequests", alias: "mergedPullRequests", arguments: ["first": 20, "states": "MERGED"], type: .nonNull(.object(MergedPullRequest.selections))),
          GraphQLField("pullRequests", alias: "closedPullRequests", arguments: ["first": 20, "states": "CLOSED"], type: .nonNull(.object(ClosedPullRequest.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(openPullRequests: OpenPullRequest, mergedPullRequests: MergedPullRequest, closedPullRequests: ClosedPullRequest) {
        self.init(unsafeResultMap: ["__typename": "Repository", "openPullRequests": openPullRequests.resultMap, "mergedPullRequests": mergedPullRequests.resultMap, "closedPullRequests": closedPullRequests.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of pull requests that have been opened in the repository.
      public var openPullRequests: OpenPullRequest {
        get {
          return OpenPullRequest(unsafeResultMap: resultMap["openPullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "openPullRequests")
        }
      }

      /// A list of pull requests that have been opened in the repository.
      public var mergedPullRequests: MergedPullRequest {
        get {
          return MergedPullRequest(unsafeResultMap: resultMap["mergedPullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "mergedPullRequests")
        }
      }

      /// A list of pull requests that have been opened in the repository.
      public var closedPullRequests: ClosedPullRequest {
        get {
          return ClosedPullRequest(unsafeResultMap: resultMap["closedPullRequests"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "closedPullRequests")
        }
      }

      public struct OpenPullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequestConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PullRequest"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PullRequestSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var pullRequestSummary: PullRequestSummary {
              get {
                return PullRequestSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

      public struct MergedPullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequestConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PullRequest"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PullRequestSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var pullRequestSummary: PullRequestSummary {
              get {
                return PullRequestSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

      public struct ClosedPullRequest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PullRequestConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PullRequest"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PullRequestSummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var pullRequestSummary: PullRequestSummary {
              get {
                return PullRequestSummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoriesSummaryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query RepositoriesSummary {
      viewer {
        __typename
        repositories(first: 100) {
          __typename
          nodes {
            __typename
            ...RepositorySummary
          }
        }
      }
    }
    """

  public let operationName: String = "RepositoriesSummary"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RepositorySummary.fragmentDefinition)
    return document
  }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("repositories", arguments: ["first": 100], type: .nonNull(.object(Repository.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(repositories: Repository) {
        self.init(unsafeResultMap: ["__typename": "User", "repositories": repositories.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of repositories that the user owns.
      public var repositories: Repository {
        get {
          return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositories")
        }
      }

      public struct Repository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(RepositorySummary.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositorySummary: RepositorySummary {
              get {
                return RepositorySummary(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class AddStarToRepositoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddStarToRepository($repositoryId: ID!) {
      addStar(input: {starrableId: $repositoryId}) {
        __typename
        starrable {
          __typename
          ...RepositorySummary
        }
      }
    }
    """

  public let operationName: String = "AddStarToRepository"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RepositorySummary.fragmentDefinition)
    return document
  }

  public var repositoryId: GraphQLID

  public init(repositoryId: GraphQLID) {
    self.repositoryId = repositoryId
  }

  public var variables: GraphQLMap? {
    return ["repositoryId": repositoryId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addStar", arguments: ["input": ["starrableId": GraphQLVariable("repositoryId")]], type: .object(AddStar.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addStar: AddStar? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addStar": addStar.flatMap { (value: AddStar) -> ResultMap in value.resultMap }])
    }

    /// Adds a star to a Starrable.
    public var addStar: AddStar? {
      get {
        return (resultMap["addStar"] as? ResultMap).flatMap { AddStar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addStar")
      }
    }

    public struct AddStar: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AddStarPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("starrable", type: .object(Starrable.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(starrable: Starrable? = nil) {
        self.init(unsafeResultMap: ["__typename": "AddStarPayload", "starrable": starrable.flatMap { (value: Starrable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable? {
        get {
          return (resultMap["starrable"] as? ResultMap).flatMap { Starrable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Repository", "Topic", "Gist"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositorySummary.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTopic() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Topic"])
        }

        public static func makeGist() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Gist"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var repositorySummary: RepositorySummary? {
            get {
              if !RepositorySummary.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
              return RepositorySummary(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class RemoveStarToRepositoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RemoveStarToRepository($repositoryId: ID!) {
      removeStar(input: {starrableId: $repositoryId}) {
        __typename
        starrable {
          __typename
          ...RepositorySummary
        }
      }
    }
    """

  public let operationName: String = "RemoveStarToRepository"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RepositorySummary.fragmentDefinition)
    return document
  }

  public var repositoryId: GraphQLID

  public init(repositoryId: GraphQLID) {
    self.repositoryId = repositoryId
  }

  public var variables: GraphQLMap? {
    return ["repositoryId": repositoryId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("removeStar", arguments: ["input": ["starrableId": GraphQLVariable("repositoryId")]], type: .object(RemoveStar.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeStar: RemoveStar? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "removeStar": removeStar.flatMap { (value: RemoveStar) -> ResultMap in value.resultMap }])
    }

    /// Removes a star from a Starrable.
    public var removeStar: RemoveStar? {
      get {
        return (resultMap["removeStar"] as? ResultMap).flatMap { RemoveStar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "removeStar")
      }
    }

    public struct RemoveStar: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RemoveStarPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("starrable", type: .object(Starrable.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(starrable: Starrable? = nil) {
        self.init(unsafeResultMap: ["__typename": "RemoveStarPayload", "starrable": starrable.flatMap { (value: Starrable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable? {
        get {
          return (resultMap["starrable"] as? ResultMap).flatMap { Starrable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Repository", "Topic", "Gist"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositorySummary.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTopic() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Topic"])
        }

        public static func makeGist() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Gist"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var repositorySummary: RepositorySummary? {
            get {
              if !RepositorySummary.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
              return RepositorySummary(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class WatchRepositoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation WatchRepository($repositoryId: ID!) {
      updateSubscription(input: {state: SUBSCRIBED, subscribableId: $repositoryId}) {
        __typename
        subscribable {
          __typename
          ...RepositorySummary
        }
      }
    }
    """

  public let operationName: String = "WatchRepository"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RepositorySummary.fragmentDefinition)
    return document
  }

  public var repositoryId: GraphQLID

  public init(repositoryId: GraphQLID) {
    self.repositoryId = repositoryId
  }

  public var variables: GraphQLMap? {
    return ["repositoryId": repositoryId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateSubscription", arguments: ["input": ["state": "SUBSCRIBED", "subscribableId": GraphQLVariable("repositoryId")]], type: .object(UpdateSubscription.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateSubscription: UpdateSubscription? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateSubscription": updateSubscription.flatMap { (value: UpdateSubscription) -> ResultMap in value.resultMap }])
    }

    /// Updates the state for subscribable subjects.
    public var updateSubscription: UpdateSubscription? {
      get {
        return (resultMap["updateSubscription"] as? ResultMap).flatMap { UpdateSubscription(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateSubscription")
      }
    }

    public struct UpdateSubscription: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateSubscriptionPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("subscribable", type: .object(Subscribable.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subscribable: Subscribable? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateSubscriptionPayload", "subscribable": subscribable.flatMap { (value: Subscribable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The input subscribable entity.
      public var subscribable: Subscribable? {
        get {
          return (resultMap["subscribable"] as? ResultMap).flatMap { Subscribable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "subscribable")
        }
      }

      public struct Subscribable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Issue", "PullRequest", "Repository", "Team", "TeamDiscussion", "Commit"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositorySummary.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeIssue() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "PullRequest"])
        }

        public static func makeTeam() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Team"])
        }

        public static func makeTeamDiscussion() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "TeamDiscussion"])
        }

        public static func makeCommit() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Commit"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var repositorySummary: RepositorySummary? {
            get {
              if !RepositorySummary.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
              return RepositorySummary(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class UnwatchRepositoryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UnwatchRepository($repositoryId: ID!) {
      updateSubscription(input: {state: IGNORED, subscribableId: $repositoryId}) {
        __typename
        subscribable {
          __typename
          ...RepositorySummary
        }
      }
    }
    """

  public let operationName: String = "UnwatchRepository"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RepositorySummary.fragmentDefinition)
    return document
  }

  public var repositoryId: GraphQLID

  public init(repositoryId: GraphQLID) {
    self.repositoryId = repositoryId
  }

  public var variables: GraphQLMap? {
    return ["repositoryId": repositoryId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateSubscription", arguments: ["input": ["state": "IGNORED", "subscribableId": GraphQLVariable("repositoryId")]], type: .object(UpdateSubscription.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateSubscription: UpdateSubscription? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateSubscription": updateSubscription.flatMap { (value: UpdateSubscription) -> ResultMap in value.resultMap }])
    }

    /// Updates the state for subscribable subjects.
    public var updateSubscription: UpdateSubscription? {
      get {
        return (resultMap["updateSubscription"] as? ResultMap).flatMap { UpdateSubscription(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateSubscription")
      }
    }

    public struct UpdateSubscription: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateSubscriptionPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("subscribable", type: .object(Subscribable.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subscribable: Subscribable? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateSubscriptionPayload", "subscribable": subscribable.flatMap { (value: Subscribable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The input subscribable entity.
      public var subscribable: Subscribable? {
        get {
          return (resultMap["subscribable"] as? ResultMap).flatMap { Subscribable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "subscribable")
        }
      }

      public struct Subscribable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Issue", "PullRequest", "Repository", "Team", "TeamDiscussion", "Commit"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositorySummary.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeIssue() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "PullRequest"])
        }

        public static func makeTeam() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Team"])
        }

        public static func makeTeamDiscussion() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "TeamDiscussion"])
        }

        public static func makeCommit() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Commit"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var repositorySummary: RepositorySummary? {
            get {
              if !RepositorySummary.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
              return RepositorySummary(unsafeResultMap: resultMap)
            }
            set {
              guard let newValue = newValue else { return }
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct CommitSummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment CommitSummary on Commit {
      __typename
      author {
        __typename
        ...AuthorSummary
      }
      abbreviatedOid
      message
      committedDate
    }
    """

  public static let possibleTypes: [String] = ["Commit"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("author", type: .object(Author.selections)),
      GraphQLField("abbreviatedOid", type: .nonNull(.scalar(String.self))),
      GraphQLField("message", type: .nonNull(.scalar(String.self))),
      GraphQLField("committedDate", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(author: Author? = nil, abbreviatedOid: String, message: String, committedDate: String) {
    self.init(unsafeResultMap: ["__typename": "Commit", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "abbreviatedOid": abbreviatedOid, "message": message, "committedDate": committedDate])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Authorship details of the commit.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// An abbreviated version of the Git object ID
  public var abbreviatedOid: String {
    get {
      return resultMap["abbreviatedOid"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "abbreviatedOid")
    }
  }

  /// The Git commit message
  public var message: String {
    get {
      return resultMap["message"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "message")
    }
  }

  /// The datetime when this commit was committed.
  public var committedDate: String {
    get {
      return resultMap["committedDate"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "committedDate")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["GitActor"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(AuthorSummary.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(avatarUrl: String, name: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "GitActor", "avatarUrl": avatarUrl, "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var authorSummary: AuthorSummary {
        get {
          return AuthorSummary(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct ReleaseSummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ReleaseSummary on Release {
      __typename
      name
      author {
        __typename
        ...AuthorInfo
      }
      publishedAt
    }
    """

  public static let possibleTypes: [String] = ["Release"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("author", type: .object(Author.selections)),
      GraphQLField("publishedAt", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String? = nil, author: Author? = nil, publishedAt: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Release", "name": name, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "publishedAt": publishedAt])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The title of the release.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The author of the release
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// Identifies the date and time when the release was created.
  public var publishedAt: String? {
    get {
      return resultMap["publishedAt"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "publishedAt")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(AuthorInfo.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(avatarUrl: String, name: String? = nil, email: String) {
      self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "email": email])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var authorInfo: AuthorInfo {
        get {
          return AuthorInfo(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct AuthorSummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment AuthorSummary on GitActor {
      __typename
      avatarUrl
      name
    }
    """

  public static let possibleTypes: [String] = ["GitActor"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(avatarUrl: String, name: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "GitActor", "avatarUrl": avatarUrl, "name": name])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A URL pointing to the author's public avatar.
  public var avatarUrl: String {
    get {
      return resultMap["avatarUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  /// The name in the Git commit.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }
}

public struct AuthorInfo: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment AuthorInfo on User {
      __typename
      avatarUrl
      name
      email
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("email", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(avatarUrl: String, name: String? = nil, email: String) {
    self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "email": email])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A URL pointing to the user's public avatar.
  public var avatarUrl: String {
    get {
      return resultMap["avatarUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  /// The user's public profile name.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The user's publicly visible profile email.
  public var email: String {
    get {
      return resultMap["email"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }
}

public struct IssueSummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment IssueSummary on Issue {
      __typename
      author {
        __typename
        ...IssueAuthor
      }
      title
      number
      createdAt
      state
    }
    """

  public static let possibleTypes: [String] = ["Issue"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("author", type: .object(Author.selections)),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("state", type: .nonNull(.scalar(IssueState.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(author: Author? = nil, title: String, number: Int, createdAt: String, state: IssueState) {
    self.init(unsafeResultMap: ["__typename": "Issue", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "title": title, "number": number, "createdAt": createdAt, "state": state])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// Identifies the issue title.
  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  /// Identifies the issue number.
  public var number: Int {
    get {
      return resultMap["number"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// Identifies the state of the issue.
  public var state: IssueState {
    get {
      return resultMap["state"]! as! IssueState
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["EnterpriseUserAccount", "Organization", "User", "Mannequin", "Bot"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(IssueAuthor.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeEnterpriseUserAccount(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeOrganization(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeUser(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeMannequin(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeBot(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "avatarUrl": avatarUrl, "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var issueAuthor: IssueAuthor {
        get {
          return IssueAuthor(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct IssueAuthor: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment IssueAuthor on Actor {
      __typename
      avatarUrl
      login
    }
    """

  public static let possibleTypes: [String] = ["EnterpriseUserAccount", "Organization", "User", "Mannequin", "Bot"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeEnterpriseUserAccount(avatarUrl: String, login: String) -> IssueAuthor {
    return IssueAuthor(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeOrganization(avatarUrl: String, login: String) -> IssueAuthor {
    return IssueAuthor(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeUser(avatarUrl: String, login: String) -> IssueAuthor {
    return IssueAuthor(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeMannequin(avatarUrl: String, login: String) -> IssueAuthor {
    return IssueAuthor(unsafeResultMap: ["__typename": "Mannequin", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeBot(avatarUrl: String, login: String) -> IssueAuthor {
    return IssueAuthor(unsafeResultMap: ["__typename": "Bot", "avatarUrl": avatarUrl, "login": login])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A URL pointing to the actor's public avatar.
  public var avatarUrl: String {
    get {
      return resultMap["avatarUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  /// The username of the actor.
  public var login: String {
    get {
      return resultMap["login"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "login")
    }
  }
}

public struct PullRequestSummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PullRequestSummary on PullRequest {
      __typename
      author {
        __typename
        ...PullRequestAuthor
      }
      title
      number
      createdAt
      baseRefName
      headRefName
    }
    """

  public static let possibleTypes: [String] = ["PullRequest"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("author", type: .object(Author.selections)),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("number", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("baseRefName", type: .nonNull(.scalar(String.self))),
      GraphQLField("headRefName", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(author: Author? = nil, title: String, number: Int, createdAt: String, baseRefName: String, headRefName: String) {
    self.init(unsafeResultMap: ["__typename": "PullRequest", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "title": title, "number": number, "createdAt": createdAt, "baseRefName": baseRefName, "headRefName": headRefName])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// Identifies the pull request title.
  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  /// Identifies the pull request number.
  public var number: Int {
    get {
      return resultMap["number"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// Identifies the name of the base Ref associated with the pull request, even if the ref has been deleted.
  public var baseRefName: String {
    get {
      return resultMap["baseRefName"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "baseRefName")
    }
  }

  /// Identifies the name of the head Ref associated with the pull request, even if the ref has been deleted.
  public var headRefName: String {
    get {
      return resultMap["headRefName"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "headRefName")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["EnterpriseUserAccount", "Organization", "User", "Mannequin", "Bot"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(PullRequestAuthor.self),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeEnterpriseUserAccount(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeOrganization(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeUser(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeMannequin(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeBot(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "avatarUrl": avatarUrl, "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var pullRequestAuthor: PullRequestAuthor {
        get {
          return PullRequestAuthor(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct PullRequestAuthor: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PullRequestAuthor on Actor {
      __typename
      avatarUrl
      login
    }
    """

  public static let possibleTypes: [String] = ["EnterpriseUserAccount", "Organization", "User", "Mannequin", "Bot"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makeEnterpriseUserAccount(avatarUrl: String, login: String) -> PullRequestAuthor {
    return PullRequestAuthor(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeOrganization(avatarUrl: String, login: String) -> PullRequestAuthor {
    return PullRequestAuthor(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeUser(avatarUrl: String, login: String) -> PullRequestAuthor {
    return PullRequestAuthor(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeMannequin(avatarUrl: String, login: String) -> PullRequestAuthor {
    return PullRequestAuthor(unsafeResultMap: ["__typename": "Mannequin", "avatarUrl": avatarUrl, "login": login])
  }

  public static func makeBot(avatarUrl: String, login: String) -> PullRequestAuthor {
    return PullRequestAuthor(unsafeResultMap: ["__typename": "Bot", "avatarUrl": avatarUrl, "login": login])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// A URL pointing to the actor's public avatar.
  public var avatarUrl: String {
    get {
      return resultMap["avatarUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  /// The username of the actor.
  public var login: String {
    get {
      return resultMap["login"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "login")
    }
  }
}

public struct RepositorySummary: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RepositorySummary on Repository {
      __typename
      id
      name
      nameWithOwner
      owner {
        __typename
        login
      }
      repoDescription: description
      isPrivate
      watchers {
        __typename
        totalCount
      }
      stargazers {
        __typename
        totalCount
      }
      forks {
        __typename
        totalCount
      }
      viewerHasStarred
      viewerSubscription
    }
    """

  public static let possibleTypes: [String] = ["Repository"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("nameWithOwner", type: .nonNull(.scalar(String.self))),
      GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
      GraphQLField("description", alias: "repoDescription", type: .scalar(String.self)),
      GraphQLField("isPrivate", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("watchers", type: .nonNull(.object(Watcher.selections))),
      GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
      GraphQLField("forks", type: .nonNull(.object(Fork.selections))),
      GraphQLField("viewerHasStarred", type: .nonNull(.scalar(Bool.self))),
      GraphQLField("viewerSubscription", type: .scalar(SubscriptionState.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, nameWithOwner: String, owner: Owner, repoDescription: String? = nil, isPrivate: Bool, watchers: Watcher, stargazers: Stargazer, forks: Fork, viewerHasStarred: Bool, viewerSubscription: SubscriptionState? = nil) {
    self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "nameWithOwner": nameWithOwner, "owner": owner.resultMap, "repoDescription": repoDescription, "isPrivate": isPrivate, "watchers": watchers.resultMap, "stargazers": stargazers.resultMap, "forks": forks.resultMap, "viewerHasStarred": viewerHasStarred, "viewerSubscription": viewerSubscription])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The repository's name with owner.
  public var nameWithOwner: String {
    get {
      return resultMap["nameWithOwner"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "nameWithOwner")
    }
  }

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "owner")
    }
  }

  /// The description of the repository.
  public var repoDescription: String? {
    get {
      return resultMap["repoDescription"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "repoDescription")
    }
  }

  /// Identifies if the repository is private.
  public var isPrivate: Bool {
    get {
      return resultMap["isPrivate"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isPrivate")
    }
  }

  /// A list of users watching the repository.
  public var watchers: Watcher {
    get {
      return Watcher(unsafeResultMap: resultMap["watchers"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "watchers")
    }
  }

  /// A list of users who have starred this starrable.
  public var stargazers: Stargazer {
    get {
      return Stargazer(unsafeResultMap: resultMap["stargazers"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "stargazers")
    }
  }

  /// A list of direct forked repositories.
  public var forks: Fork {
    get {
      return Fork(unsafeResultMap: resultMap["forks"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "forks")
    }
  }

  /// Returns a boolean indicating whether the viewing user has starred this starrable.
  public var viewerHasStarred: Bool {
    get {
      return resultMap["viewerHasStarred"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerHasStarred")
    }
  }

  /// Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
  public var viewerSubscription: SubscriptionState? {
    get {
      return resultMap["viewerSubscription"] as? SubscriptionState
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerSubscription")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Organization", "User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeUser(login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }

  public struct Watcher: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["UserConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "UserConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct Stargazer: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["StargazerConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "StargazerConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct Fork: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["RepositoryConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}
