extends Area3D


func _on_body_entered(body):
	if body.name=="Player" and body.has_method("enter_water"):
		body.enter_water()
