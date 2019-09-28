import Foundation
import Combine

/** 
	A subject that can be manually refreshed by its subscriber, as opposed to the imperative
	updates of `PassthroughSubject`. 

	`RefreshableSubject` does not cache the most recent published value as `CurrentValueSubject` 
	does, although this could be implemented by the `Refreshable` service that calls `send.`

	This class is not intended to be subclassed. Instead a service provider should conform to 
	`Refreshable` and expose a reference to this publisher.

	`RefreshableSubject` supports multiple subscriptions.
*/
@available(macOS 10.15, *)
public class RefreshableSubject<T>: Subject {

	//MARK: Properties
	private var subscriptions = [RefreshableSubjectSubscription<Output>]()
	private let service: RefreshableService

	public func refresh() {
		Swift.print("Refreshing...")
	}

	public init(service: RefreshableService) {
		self.service = service
	}

	//MARK: Publisher Protocol
	public typealias Output = T
	public typealias Failure = Error

	public func receive<S>(subscriber: S) where S:Subscriber, S.Input == Output, S.Failure == Failure {
		Swift.print("Subscriber received!")
		let subscription = RefreshableSubjectSubscription(publisher: self, subscriber: AnySubscriber(subscriber))
		self.subscriptions.append(subscription)
	}

	//MARK: Subject Extension
	public func send(_ output: Output) {
		for subscription in subscriptions {
			Swift.print("Sending output...")
			_ = subscription.subscriber.receive(output)
		}
	}

	public func send(completion: Subscribers.Completion<Failure>) {
		Swift.print("Sending completion...")
		for subscription in subscriptions {
			subscription.subscriber.receive(completion: completion)
		}
	}

	public func send(subscription: Subscription) {
		//do nothing
		Swift.print("Sending subscription... (not implemented)")
	}
}
