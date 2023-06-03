import CGtk

extension View {
    /// Positions this view within an invisible frame having the specified size constraints.
    public func frame(minWidth: Int? = nil, minHeight: Int? = nil) -> some View {
        return SimpleFrameModifierView(
            body: ViewContent1(self),
            minWidth: minWidth,
            minHeight: minHeight
        )
    }

    @available(*, unavailable)
    public func frame() -> some View {
        return self
    }

    public func frame(
        minWidth: Double? = nil,
        idealWidth: Double? = nil,
        maxWidth: Double? = nil,
        minHeight: Double? = nil,
        idealHeight: Double? = nil,
        maxHeight: Double? = nil
        // alignment: // TODO: Set alignment
    ) -> some View {
        return ConstraintsFrameModifierView(
            body: ViewContent1(self),
            minWidth: minWidth,
            idealWidth: idealWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            idealHeight: idealHeight,
            maxHeight: maxHeight
        )
    }
}

/// A view used to manage a child view's size.
private struct SimpleFrameModifierView<Child: View>: View {
    var body: ViewContent1<Child>

    var minWidth: Int?
    var minHeight: Int?

    func asWidget(_ children: ViewGraphNodeChildren1<Child>) -> GtkSingleChildBox {
        let widget = GtkSingleChildBox()
        widget.setChild(children.child0.widget)
        return widget
    }

    func update(_ widget: GtkSingleChildBox, children: ViewGraphNodeChildren1<Child>) {
        widget.sizeRequest = (minWidth ?? -1, minHeight ?? -1)
    }
}

private struct ConstraintsFrameModifierView<Child: View>: View {
    var body: ViewContent1<Child>

    var minWidth: Double?
    var idealWidth: Double?
    var maxWidth: Double?

    var minHeight: Double?
    var idealHeight: Double?
    var maxHeight: Double?

    func asWidget(_ children: ViewGraphNodeChildren1<Child>) -> GtkSingleChildBox {
        let widget = GtkSingleChildBox()
        widget.setChild(children.child0.widget)
        children.child0.widget.expandHorizontally = true
        return widget
    }

    func update(_ widget: GtkSingleChildBox, children: ViewGraphNodeChildren1<Child>) {
        if let minWidth {
            widget.setConstraint(for: .width, .greaterThanOrEqual, constant: minWidth)
        } else {
            widget.removeConstraint(for: .width, .greaterThanOrEqual)
        }
        if let idealWidth {
            widget.setConstraint(for: .width, .equal, constant: idealWidth, strength: GTK_CONSTRAINT_STRENGTH_WEAK.rawValue)
        } else {
            widget.removeConstraint(for: .width, .equal)
        }
        if let maxWidth {
            widget.setConstraint(for: .width, .lessThanOrEqual, constant: maxWidth)
        } else {
            widget.removeConstraint(for: .width, .lessThanOrEqual)
        }

        if let minHeight {
            widget.setConstraint(for: .height, .greaterThanOrEqual, constant: minHeight)
        } else {
            widget.removeConstraint(for: .height, .greaterThanOrEqual)
        }
        if let idealHeight {
            widget.setConstraint(for: .height, .equal, constant: idealHeight, strength: GTK_CONSTRAINT_STRENGTH_WEAK.rawValue)
        } else {
            widget.removeConstraint(for: .height, .equal)
        }
        if let maxHeight {
            widget.setConstraint(for: .height, .lessThanOrEqual, constant: maxHeight)
        } else {
            widget.removeConstraint(for: .height, .lessThanOrEqual)
        }
    }
}
