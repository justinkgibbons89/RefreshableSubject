import Foundation
import RefreshableSubject
import Combine

if #available(macOS 10.15, *) {

class Service: RefreshableService {

	lazy var subject: RefreshableSubject<String> = {
		RefreshableSubject(service: self)
	}()

	var cancellable: AnyCancellable?

	public func refresh() {
		print("Refresh called on service")
		subject.send("hello")
	}
}

	let service = Service()

	service.cancellable = service.subject
		.sink(receiveCompletion: { completion in 
			print("Complete", completion)
		}) { value in
			print("value", value)
		}

	service.refresh()
	service.subject.send("hey what")
}
