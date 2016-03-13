import CCairo

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
	public func paint() { cairo_paint(ctx) }

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

	public func setSource(pattern: Pattern) {
		currentPattern = pattern
		cairo_set_source(ctx, currentPattern!._cairoPattern())
	}

	public func setSource(r r: Double, g: Double, b: Double) {
		currentPattern = Pattern(r: r, g: g, b: b)
		cairo_set_source(ctx, currentPattern!._cairoPattern())
	}

	public func setSource(r r: Double, g: Double, b: Double, a: Double) {
		currentPattern = Pattern(r: r, g: g, b: b, a: a)
		cairo_set_source(ctx, currentPattern!._cairoPattern())
	}

	let ctx: COpaquePointer
	var currentPattern: Pattern?
}