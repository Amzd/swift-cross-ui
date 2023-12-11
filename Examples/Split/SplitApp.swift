import Foundation
import SwiftCrossUI

enum SubjectArea {
    case science
    case humanities
}

enum ScienceSubject {
    case physics
    case chemistry
}

enum HumanitiesSubject {
    case english
    case history
}

enum Columns {
    case two
    case three
}

class SplitAppState: Observable {
    @Observed var selectedArea: SubjectArea?
    @Observed var selectedDetail: Any?
    @Observed var columns: Columns = .two
    @Observed var spacing: Int = 10
    @Observed var minWidth: Int = 10
    @Observed var showA = true
}

@main
struct SplitApp: App {
    let identifier = "dev.stackotter.SplitApp"

    let state = SplitAppState()

    let windowProperties = WindowProperties(
        title: "Test",
        defaultSize: WindowProperties.Size(600, 250)
    )

    var body: some ViewContent {
        VStack {
            HStack {
                Text("Spacing:")
                Slider(state.$spacing, minimum: 0, maximum: 60)
                Text("Min width:")
                Slider(state.$minWidth, minimum: 0, maximum: 1000)
                Button("toggle", action: { state.showA.toggle() })
            }
            if state.showA {
                let _ = print("showA")
                Text("Ha").foregroundColor(.green)
            }
            NavigationLink("link", value: "br", path: Binding<NavigationPath>(get: { NavigationPath() }, set: { _ in }))
                .frame(minWidth: state.minWidth)
                .frame(minWidth: state.minWidth)
            HStack(spacing: state.spacing) {
                switch "test" {
                case "test":
                    Text("Some text here")
                    Button("Button") { }
                    Spacer()
                    if true {
                        Text("< spacer")
                        if true {
                            ForEach(["1", "2", "3"]) {
                                Text($0)
                                if true {
                                    Text("-")
                                }
                            }
                            Text("4")
                        }
                    }
                default:
                    Text("not shown")
                }
                Text("bottom level")
            }

            HStack {
                Text("A")
                Spacer()
                Text("B")
            }

            VStack {
                Text("A")
                Spacer()
                Text("B")
            }
        }
        .padding(20)
    }

    /// Example view for a two column NavigationSplitView
    var doubleColumn: some View {
        NavigationSplitView {
            VStack {
                Button("Science") { state.selectedArea = .science }
                Button("Humanities") { state.selectedArea = .humanities }
                Spacer()
                Button("Switch to 3 column example") { state.columns = .three }
            }.padding(10)
        } detail: {
            VStack {
                switch state.selectedArea {
                    case .science:
                        Text("Science")
                            .padding(.bottom, 10)
                    case .humanities:
                        Text("Humanities")
                            .padding(.bottom, 10)
                    case nil:
                        Text("Select an area")
                            .padding(.bottom, 10)
                }
            }.padding(10)
        }
    }

    /// Example view for a three column NavigationSplitView
    var tripleColumn: some View {
        NavigationSplitView {
            VStack {
                Button("Science") { state.selectedArea = .science }
                Button("Humanities") { state.selectedArea = .humanities }
                Spacer()
                Button("Switch to 2 column example") { state.columns = .two }
            }.padding(10)
        } content: {
            VStack {
                switch state.selectedArea {
                    case .science:
                        Text("Choose a science subject")
                        Button("Physics") { state.selectedDetail = ScienceSubject.physics }
                        Button("Chemistry") { state.selectedDetail = ScienceSubject.chemistry }
                    case .humanities:
                        Text("Choose a humanities subject")
                        Button("English") { state.selectedDetail = HumanitiesSubject.english }
                        Button("History") { state.selectedDetail = HumanitiesSubject.history }
                    case nil:
                        Text("Select an area")
                }
            }
            .padding(10)
            .frame(minWidth: 100)
        } detail: {
            VStack {
                switch state.selectedDetail {
                    case let subject as ScienceSubject:
                        switch subject {
                            case .physics:
                                Text("Physics is applied maths")
                            case .chemistry:
                                Text("Chemistry is applied physics")
                        }
                    case let subject as HumanitiesSubject:
                        switch subject {
                            case .english:
                                Text("I don't like essays")
                            case .history:
                                Text("Don't repeat it")
                        }
                    default:
                        Text("Select a subject")
                }
            }.padding(10)
        }
    }
}
