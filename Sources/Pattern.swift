import CCairo

public class Pattern {
	public init(r: Double, g: Double, b: Double) {
		pattern = cairo_pattern_create_rgb(r, g, b)
	}

	public init(r: Double, g: Double, b: Double, a: Double) {
		pattern = cairo_pattern_create_rgba(r, g, b, a)
	}

	public init(surface: ImageSurface) {
		pattern = cairo_pattern_create_for_surface(surface._cairoSurface())
	}

	deinit {
		cairo_pattern_destroy(pattern)
	}

	public func _cairoPattern() -> COpaquePointer {
		return pattern
	}

	let pattern: COpaquePointer
}