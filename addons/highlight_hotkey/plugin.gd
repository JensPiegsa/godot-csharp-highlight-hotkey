@tool
extends EditorPlugin

## Ctrl+Alt+H in the script editor: triggers Godot's own menu entry
## "Edit > Syntax Highlighter > Standard" for the current tab.
## It does not create or replace any highlighter itself, it only presses the menu item.
## The submenu is filled by Godot only when it opens, so it is asked to fill itself first.


func _input(event: InputEvent) -> void:
	var key: InputEventKey = event as InputEventKey
	if key == null or not key.pressed or key.echo:
		return
	if key.keycode != KEY_H or not key.ctrl_pressed or not key.alt_pressed:
		return
	var pressed: bool = _press_standard()
	if pressed:
		get_viewport().set_input_as_handled()


func _press_standard() -> bool:
	var script_editor: Control = EditorInterface.get_script_editor()
	if script_editor == null or not script_editor.is_visible_in_tree():
		return false
	var menus: Array[PopupMenu] = []
	_collect_menus(script_editor, menus)
	for menu: PopupMenu in menus:
		if not _belongs_to_visible_control(menu):
			continue
		for i: int in menu.item_count:
			var text: String = menu.get_item_text(i)
			if text != "Syntax Highlighter" and text != "Syntaxhervorhebung":
				continue
			var sub: PopupMenu = menu.get_item_submenu_node(i)
			if sub == null:
				continue
			if sub.item_count == 0:
				sub.about_to_popup.emit()
			for k: int in sub.item_count:
				if sub.get_item_text(k) == "Standard":
					sub.id_pressed.emit(sub.get_item_id(k))
					return true
	return false


## Menus of MenuButtons are internal children, so they have to be collected including internal nodes.
func _collect_menus(node: Node, result: Array[PopupMenu]) -> void:
	for child: Node in node.get_children(true):
		if child is PopupMenu:
			result.append(child as PopupMenu)
		_collect_menus(child, result)


func _belongs_to_visible_control(node: Node) -> bool:
	var parent: Node = node.get_parent()
	while parent != null:
		if parent is Control:
			return (parent as Control).is_visible_in_tree()
		parent = parent.get_parent()
	return false
