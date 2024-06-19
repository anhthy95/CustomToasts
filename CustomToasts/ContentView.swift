import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DataViewModel()

    var body: some View {
        VStack {
            Text(viewModel.data)
                .padding()

            Button("Fetch Data Successfully") {
                viewModel.fetchData()
            }
            .padding()

            Button("Fetch Data with Failure") {
                viewModel.fetchFailingData()
            }
            .padding()

            Button("Present Toast") {
                Toast.shared.present(
                    title: "AirPods Pro",
                    symbol: "airpodspro",
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
            .padding()

            Button("Present Center Toast") {
                CenterToast.shared.present(
                    title: "Center Notification",
                    symbol: "bell",
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    RootView {
        ContentView()
    }
}

