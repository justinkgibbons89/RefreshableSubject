import Foundation
import Combine 

/** 
	A concrete subscription used by `RefreshableSubject`.

	This subscription holds a reference to both publisher and subscriber, so that published
	data can be pushed downstream to the subscriber, and manual refresh calls can be pushed upstream
	to the `RefreshableSubject`.

	Generally there is no need to interact directly with this class and its subject holds a private
	reference to it. `RefreshableSubject` flows should be customized by implementing a `Refreshable`–conforming service above it, a custom subsciber beneath
	it, or both.
*/
@available(iOS 13.0, watchOS 6.0, macOS 10.15, *)
public class RefreshableSubjectSubscription<Output>: Subscription {

	private var publisher: RefreshableSubject<Output>
	public var subscriber: AnySubscriber<Output, Error>

	internal init(publisher: RefreshableSubject<Output>, subscriber: AnySubscriber<Output, Error>) {
		self.publisher = publisher
		self.subscriber = subscriber
	}

	public func request(_ demand: Subscribers.Demand) {
		Swift.print("Demand", demand)
		publisher.refresh()
	}

	public func cancel() {
		Swift.print("Cancel!")
	}
}
