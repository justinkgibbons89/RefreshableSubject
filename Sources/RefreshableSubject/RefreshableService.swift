import Foundation

/**
	A protocol for refreshable conformance.
*/
public protocol RefreshableService {
	func refresh() -> Void
}
