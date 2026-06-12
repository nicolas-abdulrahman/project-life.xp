class_name AppThemeData
extends Resource

enum IconSize {
	SMALL,
	NORMAL,
	BIG,
	LARGE,
}


const blue = "b2ebff"
const red = "ffb4b4"
const white = "ffffff"
static func get_value(size: IconSize) -> int:
	match size:
		IconSize.SMALL: return 25
		IconSize.NORMAL: return 35
		IconSize.BIG: return 50
		IconSize.LARGE: return 65
	return 35
