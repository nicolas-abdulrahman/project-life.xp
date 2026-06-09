class_name AppThemeData
extends Resource

enum IconSize {
	SMALL,
	NORMAL,
	BIG
}

static func get_value(size: IconSize) -> int:
	match size:
		IconSize.SMALL: return 25
		IconSize.NORMAL: return 35
		IconSize.BIG: return 50
	return 35
