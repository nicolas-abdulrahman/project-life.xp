extends Control

# This script now primarily handles top-level screen logic.
# Scheduler logic has been moved to schedule.gd for better organization.

var daily_routine_section: VBoxContainer
var schedule_section: VBoxContainer
var calendar_section: VBoxContainer
var v_container: VBoxContainer

func _ready():
	await get_tree().process_frame
	
	# Discovery
	v_container = find_child("VBoxContainer2", true, false)
	
	# Ensure visibility and centering of the 3 main sections
	_center_all_sections()

func _center_all_sections():
	if not v_container: return
	
	for section in v_container.get_children():
		if section is VBoxContainer:
			section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			section.visible = true
			
			var inner_vbox = section.find_child("VBoxContainer", true, false)
			if inner_vbox:
				inner_vbox.alignment = BoxContainer.ALIGNMENT_CENTER
				for content in inner_vbox.get_children():
					if content is Label:
						content.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					elif content is PanelContainer:
						content.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
