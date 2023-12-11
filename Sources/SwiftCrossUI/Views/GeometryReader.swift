struct GeometryReader<Content: ViewContent>: View {
    var body: some ViewContent {
        content(storage.proxy)
    }

    var content: (GeometryProxy) -> Content

    private var storage = Storage()

    class Storage {
        var proxy: GeometryProxy

        init() {
            proxy = GeometryProxy()
        }
    }

    init(@ViewContentBuilder content: (GeometryProxy) -> Content) {
        fatalError()
    }
}

struct GeometryProxy {

}
