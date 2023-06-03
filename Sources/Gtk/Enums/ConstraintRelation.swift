import CGtk

/// The relation between two terms of a constraint.
///
/// [Gtk docs](https://docs.gtk.org/gtk4/enum.ConstraintRelation.html)
public enum ConstraintRelation: GValueRepresentableEnum {
    case lessThanOrEqual
    case equal
    case greaterThanOrEqual

    public func toGtk() -> GtkConstraintRelation {
        switch self {
        case .lessThanOrEqual:
            return GTK_CONSTRAINT_RELATION_LE
        case .equal:
            return GTK_CONSTRAINT_RELATION_EQ
        case .greaterThanOrEqual:
            return GTK_CONSTRAINT_RELATION_GE
        }
    }

    public init(rawGtkValue: Int32) {
        switch rawGtkValue {
        case GTK_CONSTRAINT_RELATION_LE.rawValue:
            self = .lessThanOrEqual
        case GTK_CONSTRAINT_RELATION_EQ.rawValue:
            self = .equal
        case GTK_CONSTRAINT_RELATION_GE.rawValue:
            self = .greaterThanOrEqual
        default:
            fatalError("Unsupported GtkConstraintRelation enum value: \(rawGtkValue)")
        }
    }
}

extension GtkConstraintRelation {
    func toConstraintRelation() -> ConstraintRelation {
        ConstraintRelation(rawGtkValue: rawValue)
    }
}
