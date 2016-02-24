import CCairo

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