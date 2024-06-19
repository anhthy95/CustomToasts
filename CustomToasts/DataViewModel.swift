import SwiftUI
import Combine

class DataViewModel: ObservableObject {
    @Published var data: String = ""
    private var cancellables = Set<AnyCancellable>()

    func fetchData() {
        // Simulating a network fetch with a delay
        Just("Fetched Data")
            .delay(for: 2.0, scheduler: DispatchQueue.main)
            .sink { [weak self] data in
                self?.data = data
                // Show success toast notification
                Toast.shared.present(
                    title: "Data Fetched Successfully",
                    symbol: "checkmark.circle",
                    isUserInteractionEnabled: false,
                    timing: .medium
                )
            }
            .store(in: &cancellables)
    }

    func fetchFailingData() {
        // Simulating a network fetch failure with a delay
        Future<String, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                promise(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                // Show failure toast notification
                CenterToast.shared.present(
                    title: "Failed to Fetch Data",
                    symbol: "xmark.circle",
                    isUserInteractionEnabled: false,
                    timing: .medium
                )
            case .finished:
                break
            }
        }, receiveValue: { [weak self] data in
            self?.data = data
        })
        .store(in: &cancellables)
    }
}
