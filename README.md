# GraphicsContextTransforms

The base transform for a graphics context is already set for you when you obtain the context; that’s how the system is able to map context drawing coordinates onto screen coordinates. Whatever transforms you apply are applied to the current transform, so the base transform remains in effect and drawing continues to work. You can return to the base transform after applying your own transforms by wrapping your code in calls to saveGState and restoreGState.

A rotate transform is particularly useful, allowing you to draw in a rotated orientation without any nasty trigonometry. However, it’s a bit tricky because the point around which the rotation takes place is the origin. This is rarely what you want, so you have to apply a translate transform first, to map the origin to the point around which you really want to rotate. But then, after rotating, in order to figure out where to draw, you will probably have to reverse your translate transform.
To illustrate, here’s code to draw our arrow repeatedly at several angles, pivoting around the end of its tail (Figure 2-20). Since the arrow will be drawn multiple times, I’ll start by encapsulating the drawing of the arrow as a UIImage. This is not merely to reduce repetition and make drawing more efficient; it’s also because we want the entire arrow to pivot, including the pattern stripes, and this is the simplest way to achieve that

In our draw(_:) implementation, we draw the arrow image multiple times:
override func draw(_ rect: CGRect) {
    let con = UIGraphicsGetCurrentContext()!
    self.arrow.draw(at:CGPoint(0,0))
    for _ in 0..<3 {
        con.translateBy(x: 20, y: 100)
        con.rotate(by: 30 * .pi/180.0)
        con.translateBy(x: -20, y: -100)
        self.arrow.draw(at:CGPoint(0,0))
    }
}
