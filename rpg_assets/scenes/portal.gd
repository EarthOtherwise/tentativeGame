extends Node3D

var destinations : Dictionary = {
	forest_1_portal = {
		scene = constantPaths.SCENE_PATHS.world1,
		nameNode = "portal_2",
		rotationNode = -90
	},
	forest_2_portal = {
		scene = constantPaths.SCENE_PATHS.world2,
		nameNode = "portal_1",
		rotationNode = -90
	}
}

@export var destination : String

func change_world(_dest : String) -> void:
	var scene_destination = load(destinations[_dest].scene)
	get_tree().change_scene_to_packed(scene_destination)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		change_world(destination)
