import CGtk

struct Constraint {
    lazy var pointer: OpaquePointer = gtk_constraint_new_constant(
        nil,
        targetAttribute.toGtk(),
        relation.toGtk(),
        constant,
        strength
    )
    let targetAttribute: ConstraintAttribute
    let relation: ConstraintRelation
    let constant: Double
    let strength: Int32
}
