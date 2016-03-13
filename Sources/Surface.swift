import CCairo

public class Surface {
	init(cairoSurface: COpaquePointer) {
		self.cairoSurface = cairoSurface
	}

	deinit {
		cairo_surface_destroy(cairoSurface)
	}

	public func flush() {
		cairo_surface_flush(cairoSurface)
	}

	public func markDirty() {
		cairo_surface_mark_dirty(cairoSurface)
	}

	public func markDirty(x x: Int, y: Int, width: Int, height: Int) {
		cairo_surface_mark_dirty_rectangle(cairoSurface, Int32(x), Int32(y), Int32(width), Int32(height))
	}

	public func _cairoSurface() -> COpaquePointer {
		return cairoSurface
	}

	let cairoSurface: COpaquePointer
}