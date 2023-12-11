//
//  Copyright © 2016 Tomas Linhart. All rights reserved.
//

import CGtk

public class Separator: Widget {
    public init(orientation: Orientation) {
        super.init()

        widgetPointer = gtk_separator_new(orientation.toGtk())
    }
}
