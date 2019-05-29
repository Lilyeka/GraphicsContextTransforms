# GraphicsContextTransforms

The base transform for a graphics context is already set for you when you obtain the context; that’s how the system is able to map context drawing coordinates onto screen coordinates. Whatever transforms you apply are applied to the current transform, so the base transform remains in effect and drawing continues to work. You can return to the base transform after applying your own transforms by wrapping your code in calls to saveGState and restoreGState.
