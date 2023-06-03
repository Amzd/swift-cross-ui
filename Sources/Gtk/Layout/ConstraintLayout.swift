import CGtk

fileprivate struct ConstraintID: Hashable {
    var attribute: ConstraintAttribute
    var relation: ConstraintRelation
}

class ConstraintLayout: GObjectRepresentable {
    var gobjectPointer: UnsafeMutablePointer<GObject>
    var pointer: UnsafeMutablePointer<GtkLayoutManager>

    private var constraints: [ConstraintID: Constraint] = [:]

    init() {
        pointer = gtk_constraint_layout_new()
        gobjectPointer = pointer.cast()
    }

    public func setConstraint(
        for attribute: ConstraintAttribute,
        _ relation: ConstraintRelation,
        constant: Double = 0,
        strength: UInt32 = GTK_CONSTRAINT_STRENGTH_STRONG.rawValue
    ) {
        let id = ConstraintID(attribute: attribute, relation: relation)

        if let existingConstraint = constraints[id] {
            guard existingConstraint.constant != constant || existingConstraint.strength != strength else {
                return // exiting because this exact constraint already exists
            }
            removeConstraint(for: attribute, relation)
        }

        var new = Constraint(targetAttribute: attribute, relation: relation, constant: constant, strength: Int32(strength))
        gtk_constraint_layout_add_constraint(OpaquePointer(pointer), new.pointer)
        gtk_layout_manager_layout_changed(pointer)
        constraints[id] = new
    }

    public func removeConstraint(for attribute: ConstraintAttribute, _ relation: ConstraintRelation) {
        let id = ConstraintID(attribute: attribute, relation: relation)
        if var constraint = constraints[id] {
            gtk_constraint_layout_remove_constraint(OpaquePointer(pointer), constraint.pointer)
            constraints[id] = nil
        }
    }
}
