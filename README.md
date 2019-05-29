# GraphicsContextTransforms

The base transform for a graphics context is already set for you when you obtain the context; that’s how the system is able to map context drawing coordinates onto screen coordinates. Whatever transforms you apply are applied to the current transform, so the base transform remains in effect and drawing continues to work. You can return to the base transform after applying your own transforms by wrapping your code in calls to saveGState and restoreGState.

A rotate transform is particularly useful, allowing you to draw in a rotated orientation without any nasty trigonometry. However, it’s a bit tricky because the point around which the rotation takes place is the origin. This is rarely what you want, so you have to apply a translate transform first, to map the origin to the point around which you really want to rotate. But then, after rotating, in order to figure out where to draw, you will probably have to reverse your translate transform.
To illustrate, here’s code to draw our arrow repeatedly at several angles, pivoting around the end of its tail.

![A](https://github.com/Lilyeka/GraphicsContextTransforms/blob/master/GraphicsContextTransforms/rotatedArrows.png "Drawing rotated")



Since the arrow will be drawn multiple times, I’ll start by encapsulating the drawing of the arrow as a UIImage. This is not merely to reduce repetition and make drawing more efficient; it’s also because we want the entire arrow to pivot, including the pattern stripes, and this is the simplest way to achieve that

In our draw(_:) implementation, we call function drawWithoutShadow() that draws the arrow image multiple times or drawWithShadow() that draws the arrow image multiple times with shadow

![A](https://github.com/Lilyeka/GraphicsContextTransforms/blob/master/GraphicsContextTransforms/rotatedArrowsWithShadows.png "Drawing rotated")

