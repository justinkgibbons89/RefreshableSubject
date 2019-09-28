import Foundation
import Combine

/** 
	A reference implementation of a `RefreshableSubject` subscriber.

	`Client` holds a reference to its `Subscription` and calls its `request:demand` method
	to trigger a refresh. This is exposed through a public `demand:demand` method.
*/
@available(macOS 10.15, *)
public class Client<T>: Subscriber {
	public typealias Input = T
	public typealias Failure = Error

	private var subscription: Subscription?

	public func receive(_ input: Input) -> Subscribers.Demand {
		Swift.print("input", input)
		return Subscribers.Demand.none
	}

	public func receive(subscription: Subscription) {
		Swift.print("subscription", subscription)
		self.subscription = subscription
	}

	public func receive(completion: Subscribers.Completion<Failure>) {
		Swift.print("completion", completion)
	}

	public func demand(_ demand: Subscribers.Demand) {
		print("Making manual demand!")
		subscription?.request(.unlimited)
	}
}