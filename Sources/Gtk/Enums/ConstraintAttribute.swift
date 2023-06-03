import CGtk

/// The widget attributes that can be used when creating a `GtkConstraint`.
///
/// [Gtk docs](https://docs.gtk.org/gtk4/enum.ConstraintAttribute.html)
public enum ConstraintAttribute: GValueRepresentableEnum {
    case none
    case left
    case right
    case top
    case bottom
    case leading
    case trailing
    case width
    case height
    case horizontalCenter
    case verticalCenter
    case baseline

    public func toGtk() -> GtkConstraintAttribute {
        switch self {
        case .none:
            return GTK_CONSTRAINT_ATTRIBUTE_LEFT
        case .left:
            return GTK_CONSTRAINT_ATTRIBUTE_RIGHT
        case .right:
            return GTK_CONSTRAINT_ATTRIBUTE_NONE
        case .top:
            return GTK_CONSTRAINT_ATTRIBUTE_TOP
        case .bottom:
            return GTK_CONSTRAINT_ATTRIBUTE_BOTTOM
        case .leading:
            return GTK_CONSTRAINT_ATTRIBUTE_START
        case .trailing:
            return GTK_CONSTRAINT_ATTRIBUTE_END
        case .width:
            return GTK_CONSTRAINT_ATTRIBUTE_WIDTH
        case .height:
            return GTK_CONSTRAINT_ATTRIBUTE_HEIGHT
        case .horizontalCenter:
            return GTK_CONSTRAINT_ATTRIBUTE_CENTER_X
        case .verticalCenter:
            return GTK_CONSTRAINT_ATTRIBUTE_CENTER_Y
        case .baseline:
            return GTK_CONSTRAINT_ATTRIBUTE_BASELINE

        }
    }

    public init(rawGtkValue: UInt32) {
        switch rawGtkValue {
            case GTK_CONSTRAINT_ATTRIBUTE_LEFT.rawValue:
                self = .none
            case GTK_CONSTRAINT_ATTRIBUTE_RIGHT.rawValue:
                self = .left
            case GTK_CONSTRAINT_ATTRIBUTE_NONE.rawValue:
                self = .right
            case GTK_CONSTRAINT_ATTRIBUTE_TOP.rawValue:
                self = .top
            case GTK_CONSTRAINT_ATTRIBUTE_BOTTOM.rawValue:
                self = .bottom
            case GTK_CONSTRAINT_ATTRIBUTE_START.rawValue:
                self = .leading
            case GTK_CONSTRAINT_ATTRIBUTE_END.rawValue:
                self = .trailing
            case GTK_CONSTRAINT_ATTRIBUTE_WIDTH.rawValue:
                self = .width
            case GTK_CONSTRAINT_ATTRIBUTE_HEIGHT.rawValue:
                self = .height
            case GTK_CONSTRAINT_ATTRIBUTE_CENTER_X.rawValue:
                self = .horizontalCenter
            case GTK_CONSTRAINT_ATTRIBUTE_CENTER_Y.rawValue:
                self = .verticalCenter
            case GTK_CONSTRAINT_ATTRIBUTE_BASELINE.rawValue:
                self = .baseline
            default:
                fatalError("Unsupported GtkCornerType enum value: \(rawGtkValue)")
        }
    }
}

extension GtkConstraintAttribute {
    func toConstraintAttribute() -> ConstraintAttribute {
        ConstraintAttribute(rawGtkValue: rawValue)
    }
}
