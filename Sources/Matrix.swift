import CCairo

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