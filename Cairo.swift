import Ccairo

public typealias Matrix = cairo_matrix_t
extension Matrix {
	public static func zero() -> Matrix {
		return Matrix(xx: 0, yx: 0,
		              xy: 0, yy: 0,
		              x0: 0, y0: 0)
	}

	public static func identity() -> Matrix {
		return Matrix(xx: 1, yx: 0,
		              xy: 0, yy: 1,
		              x0: 0, y0: 0)
	}
}

public func *(l: Matrix, r: Double) -> Matrix {
	return Matrix(xx: l.xx * r,
				  yx: l.yx * r,
				  xy: l.xy * r,
				  yy: l.yy * r,
				  x0: l.x0 * r,
				  y0: l.y0 * r)
}

public func *(l: Matrix, r: Matrix) -> Matrix {
	return Matrix.zero()
}

public func /(l: Matrix, r: Double) -> Matrix {
	return Matrix(xx: l.xx / r,
				  yx: l.yx / r,
				  xy: l.xy / r,
				  yy: l.yy / r,
				  x0: l.x0 / r,
				  y0: l.y0 / r)
}

public func +(l: Matrix, r: Matrix) -> Matrix {
	return Matrix(xx: l.xx + r.xx,
				  yx: l.yx + r.yx,
				  xy: l.xy + r.xy,
				  yy: l.yy + r.yy,
				  x0: l.x0 + r.x0,
				  y0: l.y0 + r.y0)
}

public func -(l: Matrix, r: Matrix) -> Matrix {
	return Matrix(xx: l.xx - r.xx,
				  yx: l.yx - r.yx,
				  xy: l.xy - r.xy,
				  yy: l.yy - r.yy,
				  x0: l.x0 - r.x0,
				  y0: l.y0 - r.y0)
}

public class ImageSurface {
	public init(width: Int, height: Int) {
		theSurface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, Int32(width), Int32(height))
	}

	public init(data: UnsafeMutablePointer<UInt8>, width: Int, height: Int, stride: Int) {
		theSurface = cairo_image_surface_create_for_data(data, CAIRO_FORMAT_ARGB32, Int32(width), Int32(height), Int32(stride))
	}

	public func _cairoSurface() -> COpaquePointer {
		return theSurface
	}

	let theSurface: COpaquePointer
}

public class Context {
	public init(surface: ImageSurface) {
		ctx = cairo_create(surface._cairoSurface())
	}

	deinit {
		cairo_destroy(ctx)
	}

	public func save() { cairo_save(ctx) }
	public func restore() { cairo_restore(ctx) }

	public func clear() { cairo_paint(ctx) }

	public func beginPath() { cairo_new_path(ctx) }
	public func moveTo(x x: Double, y: Double) { cairo_move_to(ctx, x, y) }
	public func lineTo(x x: Double, y: Double) { cairo_line_to(ctx, x, y) }
	public func fill() { cairo_fill(ctx) }
	public func fillPreserve() { cairo_fill_preserve(ctx) }
	public func stroke() { cairo_stroke(ctx) }
	public func strokePreserve() { cairo_stroke_preserve(ctx) }
	public func fillStroke() { fillPreserve(); stroke() }

	//
	// Transformations

	public func translate(dx dx: Double, dy: Double) { cairo_translate(ctx, dx, dy) }
	public func scale(factor: Double) { cairo_translate(ctx, factor, factor); }
	public func scale(sx sx: Double, sy: Double) { cairo_translate(ctx, sx, sy) }
	public func rotate(angle: Double) { cairo_rotate(ctx, angle) }
	public func transform(inout matrix: Matrix) { cairo_transform(ctx, &matrix) }
	public func getMatrix(inout matrix: Matrix) { cairo_get_matrix(ctx, &matrix) }
	public func setMatrix(inout matrix: Matrix) { cairo_set_matrix(ctx, &matrix) }
	public func copyMatrixTo(inout matrix: Matrix) { cairo_get_matrix(ctx, &matrix) }
	public func setIdentity() { cairo_identity_matrix(ctx) }
	public func userToDevice(inout x: Double, inout y: Double) { cairo_user_to_device(ctx, &x, &y) }
	public func userToDeviceDistance(inout dx: Double, inout dy: Double) { cairo_user_to_device(ctx, &dx, &dy) }
	public func deviceToUser(inout x: Double, inout y: Double) { cairo_device_to_user(ctx, &x, &y) }
	public func deviceToUserDistance(inout dx: Double, inout dy: Double) { cairo_device_to_user_distance(ctx, &dx, &dy) }

	//
	//

	public func setSourceColor(red red: Double, green: Double, blue: Double) {
		currentPattern = Pattern(red: red, green: green, blue: blue)
		cairo_set_source(ctx, currentPattern!._cairoPattern())
	}

	public func setSourceColor(red red: Double, green: Double, blue: Double, alpha: Double) {
		currentPattern = Pattern(red: red, green: green, blue: blue, alpha: alpha)
		cairo_set_source(ctx, currentPattern!._cairoPattern())
	}

	let ctx: COpaquePointer
	var currentPattern: Pattern?
}

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