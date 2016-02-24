import PackageDescription

let package = Package(
	name: "Cairo",
	targets: [],
	dependencies: [
		.Package(
			url: "https://github.com/jaz303/CCairo.swift.git",
			majorVersion: 1
		)
	]
)