import CCairo

public class ImageSurface : Surface {
	public init(width: Int, height: Int, format: Format = CAIRO_FORMAT_ARGB32) {
		super.init(cairoSurface: cairo_image_surface_create(format, Int32(width), Int32(height)))
	}

	public init(data: UnsafeMutablePointer<UInt8>, width: Int, height: Int, stride: Int, format: Format = CAIRO_FORMAT_ARGB32) {
		super.init(cairoSurface: cairo_image_surface_create_for_data(data, format, Int32(width), Int32(height), Int32(stride)))
	}

	public var data: UnsafeMutablePointer<UInt8> {
		return cairo_image_surface_get_data(cairoSurface)
	}

	public var format: Format {
		return cairo_image_surface_get_format(cairoSurface)
	}

	public var width: Int {
		return Int(cairo_image_surface_get_width(cairoSurface))
	}

	public var height: Int {
		return Int(cairo_image_surface_get_height(cairoSurface))
	}

	public var stride: Int {
		return Int(cairo_image_surface_get_stride(cairoSurface))
	}
}
