import CGtk

public protocol GObjectRepresentable {
    var gobjectPointer: UnsafeMutablePointer<GObject> { get }
}

extension GObjectRepresentable {
    public func setProperty<V: GValueRepresentable>(named: String, newValue: V) {
        var v = GValue()
        let value = g_value_init(&v, V.type)!
        newValue.apply(to: value)
        g_object_set_property(gobjectPointer, named, value)
    }

    public func getProperty<V: GValueRepresentable>(named: String) -> V {
        var v = GValue()
        let value = g_value_init(&v, V.type)!
        g_object_get_property(gobjectPointer, named, value)
        // If this returned an optional at runtime and crashed it is because the
        // underlying value was nil while `V` was not `Optional<GValueRepresentable>`.
        // Change to optional at caller site. eg:
        //
        // -@GObjectProperty(named: "optional-value") var value: String
        // +@GObjectProperty(named: "optional-value") var value: String?
        return V(value)!
    }
}
