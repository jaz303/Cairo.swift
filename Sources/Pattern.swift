import CCairo

public class Pattern {
	public init(red: Double, green: Double, blue: Double) {
		pattern = cairo_pattern_create_rgb(red, green, blue)
	}

	public init(red: Double, green: Double, blue: Double, alpha: Double) {
		pattern = cairo_pattern_create_rgba(red, green, blue, alpha)
	}

	deinit {
		cairo_pattern_destroy(pattern)
	}

	public func _cairoPattern() -> COpaquePointer {
		return pattern
	}

	let pattern: COpaquePointer
}