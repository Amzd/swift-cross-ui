/// A view that overlays its subviews, aligning them in both axes.
///
/// ZStack assigns each successive subview a higher z-axis value than the one before it, meaning later subviews appear “on top” of earlier ones.
// public struct ZStack<Content: ViewContent>: View {
//     public var body: Content

//     /// The amount of spacing to apply between children.
//     private var alignment: Never

//     /// Creates a new VStack.
//     public init(alignment: Never, @ViewContentBuilder _ content: () -> Content) {
//         body = content()
//         self.alignment = alignment
//     }

//     public func asWidget(_ children: Content.Children) -> GtkOverlay {
//         let vStack = GtkBox(orientation: .vertical).debugName(Self.self)
//         for widget in children.widgets {
//             vStack.add(widget)
//         }
//         return vStack
//     }

//     public func update(_ widget: GtkBox, children: Content.Children) {}
// }
