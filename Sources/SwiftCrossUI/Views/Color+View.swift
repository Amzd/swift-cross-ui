extension Color: View {
    public var body: some ViewContent {
        CSSModifierView(EmptyViewContent(), properties: [
            .backgroundColor(self.gtkColor)
        ])
    }
}
