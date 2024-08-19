extends Node

@export var use_draw_line: bool = true
@onready var draw_debug = $MeshInstance3D

func _physics_process(_delta) -> void:
	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.clear_surfaces()

func draw_line(point_a: Vector3, point_b: Vector3, color: Color = Color.RED):
	if !Global.Debug_Settings.draw_debug_lines: return
	if point_a.is_equal_approx(point_b):
		return
	
	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		draw_debug.mesh.surface_set_color(color)
		
		draw_debug.mesh.surface_add_vertex(point_a)
		draw_debug.mesh.surface_add_vertex(point_b)
		
		draw_debug.mesh.surface_end()

func draw_line_relative(point_a: Vector3, point_b: Vector3, color: Color = Color.RED):
	if !Global.Debug_Settings.draw_debug_lines: return
	draw_line(point_a, point_a+point_b, color)

func draw_line_relative_thick(point_a: Vector3, point_b: Vector3, thickness: float = 2.0, color: Color = Color.RED):
	if !Global.Debug_Settings.draw_debug_lines: return
	point_b = point_a + point_b
	if point_a.is_equal_approx(point_b): return
	
	if draw_debug.mesh is ImmediateMesh:
		draw_debug.mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		draw_debug.mesh.surface_set_color(color)
		
		var scale_factor := 100.0
		
		var dir := point_a.direction_to(point_b)
		var EPISILON = 0.00001
		
		var normal := Vector3(-dir.y, dir.x, 0).normalized() \
			if (abs(dir.x) + abs(dir.y) > EPISILON) \
			else Vector3(0, -dir.z, dir.y).normalized()
		normal *= thickness / scale_factor
		
		var vertices_strip_order = [4, 5, 0, 1, 2, 5, 6, 4, 7, 0, 3, 2, 7, 6]
		var local_b = (point_a - point_b)
		for v in range(14):
			var vertex = normal if \
				vertices_strip_order[v] < 4 else \
				normal + local_b
			var final_vert = vertex.rotated(dir, 
				PI * (0.5 * (vertices_strip_order[v] % 4) + 0.25))
			final_vert += point_a
			draw_debug.mesh.surface_add_vertex(final_vert)
		draw_debug.mesh.surface_end()
