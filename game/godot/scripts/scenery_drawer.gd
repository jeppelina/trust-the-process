extends Control
class_name SceneryDrawer
## Draws procedural room scenery behind NPCs.
## Each room gets its own _draw method with furniture, props, and atmosphere.

var current_room: String = ""
var _time: float = 0.0

# ── Drawing Constants (match StickCharacter) ──
const LINE_COLOR := Color(0.75, 0.71, 0.60)
const DIM_COLOR := Color(0.53, 0.47, 0.33)
const FAINT := Color(0.53, 0.47, 0.33, 0.3)
const VERY_FAINT := Color(0.53, 0.47, 0.33, 0.15)

func _process(delta: float) -> void:
	_time += delta
	queue_redraw()

func set_room(room_id: String) -> void:
	current_room = room_id
	queue_redraw()

func _draw() -> void:
	var w = size.x
	var h = size.y

	# Ground line
	draw_line(Vector2(0, h - 8), Vector2(w, h - 8), Color(0.35, 0.30, 0.22, 0.4), 1.0)

	match current_room:
		"pavilion":
			_draw_pavilion(w, h)
		"path":
			_draw_path(w, h)
		"garden":
			_draw_garden(w, h)

# ═══════════════════════════════════════════════
# THE WELCOME PAVILION
# Reception desk, Dell laptop, crystals, incense,
# wind chimes, a "WELCOME HOME" banner
# ═══════════════════════════════════════════════
func _draw_pavilion(w: float, h: float) -> void:
	var ground = h - 8

	# ── Distant mountains ──
	var mt_color = Color(0.20, 0.22, 0.17, 0.3)
	var mt_pts = PackedVector2Array([
		Vector2(0, h * 0.55),
		Vector2(w * 0.12, h * 0.35),
		Vector2(w * 0.25, h * 0.50),
		Vector2(w * 0.38, h * 0.30),
		Vector2(w * 0.52, h * 0.45),
		Vector2(w * 0.65, h * 0.28),
		Vector2(w * 0.78, h * 0.42),
		Vector2(w * 0.90, h * 0.32),
		Vector2(w, h * 0.48),
		Vector2(w, ground),
		Vector2(0, ground),
	])
	draw_colored_polygon(mt_pts, mt_color)

	# ── Prayer flags string across the top ──
	var flag_y = h * 0.12
	draw_line(Vector2(w * 0.05, flag_y), Vector2(w * 0.95, flag_y - 4), FAINT, 1.0)
	var flag_colors = [
		Color(0.83, 0.42, 0.54, 0.15),  # pink
		Color(0.42, 0.60, 0.83, 0.15),  # blue
		Color(0.83, 0.64, 0.29, 0.15),  # gold
		Color(0.54, 0.83, 0.42, 0.15),  # green
		Color(0.54, 0.42, 0.83, 0.15),  # purple
	]
	for i in 8:
		var fx = w * (0.1 + i * 0.1)
		var fy = flag_y + sin(fx * 0.01 + _time * 0.5) * 2.0
		var sway = sin(_time * 1.2 + i * 0.8) * 3.0
		var col = flag_colors[i % flag_colors.size()]
		var pts = PackedVector2Array([
			Vector2(fx, fy),
			Vector2(fx, fy + 18),
			Vector2(fx + 14 + sway, fy + 14),
		])
		draw_colored_polygon(pts, col)

	# ── RECEPTION DESK (left-center) ──
	var desk_x = w * 0.1
	var desk_y = ground - 55
	var desk_w = w * 0.32
	var desk_h = 55.0
	var desk_color = Color(0.45, 0.35, 0.22, 0.7)
	# Desk body
	draw_rect(Rect2(desk_x, desk_y, desk_w, desk_h), desk_color, true)
	# Desk top edge
	draw_rect(Rect2(desk_x - 4, desk_y - 3, desk_w + 8, 6), Color(0.50, 0.40, 0.25, 0.8), true)
	# Desk front panel line
	draw_line(Vector2(desk_x, desk_y + 20), Vector2(desk_x + desk_w, desk_y + 20), Color(0.40, 0.30, 0.18, 0.4), 1.0)

	# ── Dell laptop on desk ──
	var laptop_x = desk_x + desk_w * 0.55
	var laptop_y = desk_y - 2
	# Screen (tilted back)
	var screen_pts = PackedVector2Array([
		Vector2(laptop_x, laptop_y),
		Vector2(laptop_x + 2, laptop_y - 22),
		Vector2(laptop_x + 28, laptop_y - 22),
		Vector2(laptop_x + 30, laptop_y),
	])
	draw_colored_polygon(screen_pts, Color(0.15, 0.20, 0.25, 0.6))
	draw_polyline(screen_pts, DIM_COLOR, 1.2)
	# Screen glow
	draw_rect(Rect2(laptop_x + 4, laptop_y - 19, 24, 15), Color(0.4, 0.5, 0.6, 0.15), true)
	# Keyboard base
	draw_rect(Rect2(laptop_x - 2, laptop_y, 34, 4), Color(0.3, 0.3, 0.3, 0.5), true)

	# ── Crystals on desk ──
	var crys_x = desk_x + desk_w * 0.15
	var crys_y = desk_y - 1
	# Big amethyst
	var crys_pts = PackedVector2Array([
		Vector2(crys_x, crys_y),
		Vector2(crys_x + 4, crys_y - 16),
		Vector2(crys_x + 7, crys_y - 20),
		Vector2(crys_x + 10, crys_y - 14),
		Vector2(crys_x + 14, crys_y),
	])
	draw_polyline(crys_pts, Color(0.54, 0.42, 0.83, 0.5), 1.5)
	# Small rose quartz
	draw_polyline(PackedVector2Array([
		Vector2(crys_x + 18, crys_y),
		Vector2(crys_x + 21, crys_y - 10),
		Vector2(crys_x + 24, crys_y - 12),
		Vector2(crys_x + 27, crys_y - 8),
		Vector2(crys_x + 30, crys_y),
	]), Color(0.83, 0.54, 0.65, 0.4), 1.2)
	# Tiny clear quartz
	draw_polyline(PackedVector2Array([
		Vector2(crys_x + 34, crys_y),
		Vector2(crys_x + 36, crys_y - 8),
		Vector2(crys_x + 38, crys_y),
	]), Color(0.75, 0.75, 0.75, 0.3), 1.0)

	# ── Incense stick (right of desk) ──
	var inc_x = desk_x + desk_w + 30
	var inc_y = ground
	# Incense holder (small dish)
	draw_arc(Vector2(inc_x, inc_y - 3), 8, PI, TAU, 12, DIM_COLOR, 1.5)
	# Stick
	draw_line(Vector2(inc_x, inc_y - 3), Vector2(inc_x - 2, inc_y - 30), DIM_COLOR, 1.0)
	# Smoke wisps
	for i in 4:
		var sy = inc_y - 32 - i * 12
		var sx = inc_x - 2 + sin(_time * 0.8 + i * 1.5) * (4 + i * 3)
		var alpha = 0.25 - i * 0.05
		draw_arc(Vector2(sx, sy), 3 + i * 2, 0.0, PI, 8, Color(0.6, 0.6, 0.5, alpha), 0.8)

	# ── "WELCOME HOME" banner (right side, hung on wall) ──
	var ban_x = w * 0.68
	var ban_y = h * 0.2
	var ban_w2 = 100.0
	var ban_h2 = 28.0
	# Banner fabric
	var banner_pts = PackedVector2Array([
		Vector2(ban_x, ban_y),
		Vector2(ban_x + ban_w2, ban_y + 3),
		Vector2(ban_x + ban_w2, ban_y + ban_h2 + 3),
		Vector2(ban_x + ban_w2 * 0.5, ban_y + ban_h2 - 4),
		Vector2(ban_x, ban_y + ban_h2),
	])
	draw_colored_polygon(banner_pts, Color(0.83, 0.64, 0.29, 0.12))
	draw_polyline(banner_pts, Color(0.83, 0.64, 0.29, 0.3), 1.0)
	# String holding it
	draw_line(Vector2(ban_x, ban_y), Vector2(ban_x - 8, ban_y - 10), FAINT, 0.8)
	draw_line(Vector2(ban_x + ban_w2, ban_y + 3), Vector2(ban_x + ban_w2 + 8, ban_y - 7), FAINT, 0.8)

	# ── Potted plant (far right) ──
	var plant_x = w * 0.88
	var plant_y = ground
	# Pot
	var pot_pts = PackedVector2Array([
		Vector2(plant_x - 10, plant_y),
		Vector2(plant_x - 8, plant_y - 22),
		Vector2(plant_x + 8, plant_y - 22),
		Vector2(plant_x + 10, plant_y),
	])
	draw_colored_polygon(pot_pts, Color(0.55, 0.35, 0.20, 0.5))
	draw_polyline(pot_pts, Color(0.55, 0.35, 0.20, 0.6), 1.2)
	# Pot rim
	draw_line(Vector2(plant_x - 9, plant_y - 22), Vector2(plant_x + 9, plant_y - 22), Color(0.55, 0.35, 0.20, 0.7), 2.5)
	# Leaves
	for i in 5:
		var angle = -PI * 0.8 + i * PI * 0.3
		var length = 18 + sin(i * 2.3) * 6
		var sway = sin(_time * 0.6 + i) * 2
		var leaf_base = Vector2(plant_x, plant_y - 24)
		var leaf_tip = leaf_base + Vector2(cos(angle) * length + sway, sin(angle) * length)
		draw_line(leaf_base, leaf_tip, Color(0.35, 0.55, 0.30, 0.5), 1.5)

	# ── Small stool (left of desk) ──
	var stool_x = desk_x - 30
	var stool_y = ground
	draw_line(Vector2(stool_x - 8, stool_y - 22), Vector2(stool_x + 8, stool_y - 22), DIM_COLOR, 2.0)
	draw_line(Vector2(stool_x - 6, stool_y - 22), Vector2(stool_x - 8, stool_y), DIM_COLOR, 1.5)
	draw_line(Vector2(stool_x + 6, stool_y - 22), Vector2(stool_x + 8, stool_y), DIM_COLOR, 1.5)


# ═══════════════════════════════════════════════
# THE GARDEN PATH
# Gravel texture, hand-painted signs, prayer flags,
# oil bottles scattered, wildflowers, a "PLEASE COMPOST" sign
# ═══════════════════════════════════════════════
func _draw_path(w: float, h: float) -> void:
	var ground = h - 8

	# ── Treeline silhouettes (background) ──
	var tree_col = Color(0.15, 0.22, 0.14, 0.4)
	for i in 6:
		var tx = w * (0.05 + i * 0.18) + sin(i * 3.7) * 20
		var ty = h * 0.15
		var tw = 35 + sin(i * 2.1) * 15
		var th = ground - ty - 30
		# Tree canopy (triangle-ish)
		var tree_pts = PackedVector2Array([
			Vector2(tx, ty),
			Vector2(tx - tw * 0.5, ty + th * 0.7),
			Vector2(tx - tw * 0.3, ty + th),
			Vector2(tx + tw * 0.3, ty + th),
			Vector2(tx + tw * 0.5, ty + th * 0.7),
		])
		draw_colored_polygon(tree_pts, tree_col)
		# Trunk
		draw_line(Vector2(tx, ty + th * 0.6), Vector2(tx, ground), Color(0.30, 0.22, 0.15, 0.3), 3.0)

	# ── Gravel path (center) ──
	var path_top = ground - 6
	var path_pts = PackedVector2Array([
		Vector2(0, ground),
		Vector2(w * 0.2, path_top),
		Vector2(w * 0.8, path_top),
		Vector2(w, ground),
	])
	draw_colored_polygon(path_pts, Color(0.35, 0.32, 0.25, 0.2))
	# Gravel dots
	for i in 30:
		var gx = w * (0.22 + randf_range(0, 0.56) if i == 0 else 0.22 + fmod(i * 0.0187 + 0.13 * sin(i * 1.7), 0.56))
		var gy = ground - randf_range(0, 5) if i == 0 else ground - fmod(i * 0.15 + 0.3 * sin(i * 2.3), 5)
		# Use deterministic positions based on index
		gx = w * (0.22 + fmod(i * 0.0187 + 0.13 * sin(i * 1.7), 0.56))
		gy = ground - fmod(abs(i * 0.17 + 0.3 * sin(i * 2.3)), 5.0)
		draw_circle(Vector2(gx, gy), 1.0, Color(0.45, 0.40, 0.32, 0.2))

	# ── "YOU ARE ENOUGH" sign (left) ──
	var sign1_x = w * 0.08
	var sign1_y = ground
	# Post
	draw_line(Vector2(sign1_x + 15, sign1_y), Vector2(sign1_x + 15, sign1_y - 70), DIM_COLOR, 2.5)
	# Board
	var board1 = Rect2(sign1_x, sign1_y - 70, 50, 22)
	draw_rect(board1, Color(0.45, 0.38, 0.25, 0.5), true)
	draw_rect(board1, DIM_COLOR, false, 1.0)

	# ── "PLEASE COMPOST" sign (right) ──
	var sign2_x = w * 0.82
	var sign2_y = ground
	# Post
	draw_line(Vector2(sign2_x + 20, sign2_y), Vector2(sign2_x + 20, sign2_y - 65), DIM_COLOR, 2.5)
	# Board
	var board2 = Rect2(sign2_x, sign2_y - 65, 55, 20)
	draw_rect(board2, Color(0.45, 0.38, 0.25, 0.5), true)
	draw_rect(board2, DIM_COLOR, false, 1.0)

	# ── Prayer flags across top ──
	var flag_y = h * 0.08
	draw_line(Vector2(w * 0.02, flag_y + 4), Vector2(w * 0.98, flag_y), FAINT, 1.0)
	var flag_colors = [
		Color(0.83, 0.42, 0.54, 0.12),
		Color(0.42, 0.60, 0.83, 0.12),
		Color(0.83, 0.64, 0.29, 0.12),
		Color(0.54, 0.83, 0.42, 0.12),
		Color(0.54, 0.42, 0.83, 0.12),
	]
	for i in 10:
		var fx = w * (0.06 + i * 0.09)
		var fy = flag_y + 2 + sin(fx * 0.01) * 2
		var sway = sin(_time * 1.0 + i * 0.7) * 3.0
		var col = flag_colors[i % flag_colors.size()]
		draw_colored_polygon(PackedVector2Array([
			Vector2(fx, fy),
			Vector2(fx, fy + 16),
			Vector2(fx + 12 + sway, fy + 12),
		]), col)

	# ── Oil bottles scattered on ground (if not defeated) ──
	var bottle_col = Color(0.54, 0.42, 0.83, 0.35)
	# Bottle 1
	var b1x = w * 0.35
	draw_rect(Rect2(b1x, ground - 14, 6, 14), bottle_col, true)
	draw_rect(Rect2(b1x + 1, ground - 18, 4, 5), bottle_col, true)
	# Bottle 2 (fallen over)
	draw_rect(Rect2(w * 0.55, ground - 6, 14, 5), Color(0.54, 0.42, 0.83, 0.2), true)
	# Bottle 3
	var b3x = w * 0.65
	draw_rect(Rect2(b3x, ground - 12, 5, 12), bottle_col, true)
	draw_rect(Rect2(b3x + 0.5, ground - 16, 4, 5), bottle_col, true)

	# ── Wildflowers scattered ──
	var flower_data = [
		[0.15, Color(0.83, 0.70, 0.29, 0.3)],
		[0.28, Color(0.83, 0.42, 0.65, 0.25)],
		[0.72, Color(0.60, 0.42, 0.83, 0.3)],
		[0.90, Color(0.83, 0.70, 0.29, 0.25)],
	]
	for fd in flower_data:
		var fx2: float = w * fd[0]
		var fc: Color = fd[1]
		var stem_h = 20 + sin(fd[0] * 10) * 8
		var sway2 = sin(_time * 0.7 + fd[0] * 5) * 2
		# Stem
		draw_line(Vector2(fx2, ground), Vector2(fx2 + sway2, ground - stem_h), Color(0.35, 0.50, 0.30, 0.4), 1.0)
		# Flower head
		draw_circle(Vector2(fx2 + sway2, ground - stem_h), 3.0, fc)

	# ── Stone lantern (decorative, right-center) ──
	var lan_x = w * 0.76
	var lan_y = ground
	# Base
	draw_rect(Rect2(lan_x - 6, lan_y - 8, 12, 8), Color(0.4, 0.38, 0.32, 0.4), true)
	# Pillar
	draw_rect(Rect2(lan_x - 3, lan_y - 28, 6, 20), Color(0.4, 0.38, 0.32, 0.35), true)
	# Cap
	var cap_pts = PackedVector2Array([
		Vector2(lan_x - 10, lan_y - 28),
		Vector2(lan_x, lan_y - 36),
		Vector2(lan_x + 10, lan_y - 28),
	])
	draw_colored_polygon(cap_pts, Color(0.4, 0.38, 0.32, 0.3))
	# Tiny warm glow
	draw_circle(Vector2(lan_x, lan_y - 22), 2.5, Color(0.83, 0.64, 0.29, 0.15 + sin(_time * 2.0) * 0.05))


# ═══════════════════════════════════════════════
# THE SACRED GARDEN
# Fence being repaired, toolbox, sawhorse, coffee thermos,
# meditation cushions, crystal grid, hanging wind chimes, plants
# ═══════════════════════════════════════════════
func _draw_garden(w: float, h: float) -> void:
	var ground = h - 8

	# ── Background bushes ──
	var bush_col = Color(0.18, 0.28, 0.16, 0.35)
	for i in 5:
		var bx = w * (0.1 + i * 0.2) + sin(i * 4.1) * 15
		var by = ground - 20 - sin(i * 2.5) * 10
		var br = 25 + sin(i * 3.3) * 10
		draw_circle(Vector2(bx, by), br, bush_col)

	# ── FENCE (Frank's domain — partially repaired) ──
	var fence_y = ground - 45
	var fence_col = Color(0.50, 0.40, 0.25, 0.5)
	var fence_dim = Color(0.50, 0.40, 0.25, 0.25)
	# Fence posts
	for i in 7:
		var px = w * (0.04 + i * 0.14)
		# Some posts straight, some leaning (unrepaired)
		var lean = 0.0
		if i == 2:
			lean = 3.0  # leaning
		if i == 4:
			lean = -2.0  # slightly off
		draw_line(Vector2(px + lean, fence_y - 15), Vector2(px, ground), fence_col, 2.5)
		# Post cap
		draw_line(Vector2(px + lean - 3, fence_y - 15), Vector2(px + lean + 3, fence_y - 15), fence_col, 1.5)

	# Horizontal rails — some broken
	# Top rail (mostly intact)
	draw_line(Vector2(w * 0.04, fence_y - 8), Vector2(w * 0.32, fence_y - 8), fence_col, 1.8)
	# Gap! Broken section
	draw_line(Vector2(w * 0.38, fence_y - 5), Vector2(w * 0.46, fence_y - 12), fence_dim, 1.2)  # fallen rail piece
	# Repaired section (neater)
	draw_line(Vector2(w * 0.46, fence_y - 8), Vector2(w * 0.88, fence_y - 8), fence_col, 1.8)
	# Bottom rail
	draw_line(Vector2(w * 0.04, fence_y + 8), Vector2(w * 0.30, fence_y + 8), fence_col, 1.8)
	draw_line(Vector2(w * 0.46, fence_y + 8), Vector2(w * 0.88, fence_y + 8), fence_col, 1.8)

	# ── TOOLBOX (near where Frank stands, right side) ──
	var tb_x = w * 0.72
	var tb_y = ground
	# Box body
	var tb_rect = Rect2(tb_x, tb_y - 18, 30, 18)
	draw_rect(tb_rect, Color(0.55, 0.20, 0.15, 0.5), true)
	draw_rect(tb_rect, Color(0.60, 0.25, 0.18, 0.6), false, 1.5)
	# Handle
	draw_line(Vector2(tb_x + 8, tb_y - 18), Vector2(tb_x + 8, tb_y - 22), Color(0.6, 0.6, 0.5, 0.5), 1.5)
	draw_line(Vector2(tb_x + 22, tb_y - 18), Vector2(tb_x + 22, tb_y - 22), Color(0.6, 0.6, 0.5, 0.5), 1.5)
	draw_line(Vector2(tb_x + 8, tb_y - 22), Vector2(tb_x + 22, tb_y - 22), Color(0.6, 0.6, 0.5, 0.5), 2.0)
	# Latch
	draw_rect(Rect2(tb_x + 12, tb_y - 12, 6, 3), Color(0.7, 0.65, 0.5, 0.4), true)

	# ── Loose nails/screws on ground near toolbox ──
	draw_line(Vector2(tb_x - 8, tb_y - 2), Vector2(tb_x - 4, tb_y - 5), Color(0.6, 0.6, 0.5, 0.3), 1.0)
	draw_line(Vector2(tb_x + 34, tb_y - 1), Vector2(tb_x + 38, tb_y - 4), Color(0.6, 0.6, 0.5, 0.25), 1.0)
	draw_circle(Vector2(tb_x - 12, tb_y - 1), 1.5, Color(0.6, 0.6, 0.5, 0.2))

	# ── Sawhorse (left of center) ──
	var sh_x = w * 0.25
	var sh_y = ground
	# X-legs
	draw_line(Vector2(sh_x - 12, sh_y), Vector2(sh_x + 4, sh_y - 35), DIM_COLOR, 2.0)
	draw_line(Vector2(sh_x + 12, sh_y), Vector2(sh_x - 4, sh_y - 35), DIM_COLOR, 2.0)
	# Top bar
	draw_line(Vector2(sh_x - 8, sh_y - 35), Vector2(sh_x + 8, sh_y - 35), DIM_COLOR, 2.5)
	# Plank resting on it
	draw_rect(Rect2(sh_x - 20, sh_y - 38, 40, 4), Color(0.50, 0.40, 0.25, 0.5), true)

	# ── Coffee thermos (near toolbox) ──
	var cf_x = tb_x + 36
	var cf_y = ground
	draw_rect(Rect2(cf_x, cf_y - 20, 8, 20), Color(0.35, 0.30, 0.28, 0.5), true)
	draw_rect(Rect2(cf_x - 1, cf_y - 22, 10, 4), Color(0.40, 0.35, 0.30, 0.5), true)
	# Steam
	var steam_sway = sin(_time * 0.9) * 2
	draw_line(Vector2(cf_x + 4, cf_y - 22), Vector2(cf_x + 4 + steam_sway, cf_y - 30), Color(0.6, 0.6, 0.5, 0.2), 0.8)
	draw_line(Vector2(cf_x + 6, cf_y - 23), Vector2(cf_x + 6 - steam_sway, cf_y - 32), Color(0.6, 0.6, 0.5, 0.15), 0.8)

	# ── MEDITATION CUSHIONS (left side, abandoned) ──
	var cush_x = w * 0.08
	var cush_y = ground
	# Cushion 1 (neat)
	draw_arc(Vector2(cush_x, cush_y - 4), 12, PI, TAU, 12, Color(0.83, 0.42, 0.54, 0.3), 2.0)
	draw_line(Vector2(cush_x - 12, cush_y - 4), Vector2(cush_x + 12, cush_y - 4), Color(0.83, 0.42, 0.54, 0.3), 1.5)
	# Cushion 2 (slightly askew)
	draw_arc(Vector2(cush_x + 28, cush_y - 3), 10, PI, TAU, 12, Color(0.42, 0.60, 0.83, 0.25), 1.8)
	draw_line(Vector2(cush_x + 18, cush_y - 3), Vector2(cush_x + 38, cush_y - 3), Color(0.42, 0.60, 0.83, 0.25), 1.5)

	# ── Crystal grid on the ground (near cushions) ──
	var cg_x = cush_x + 50
	var cg_y = ground - 2
	# Circle outline
	draw_arc(Vector2(cg_x, cg_y), 15, 0, TAU, 24, Color(0.54, 0.42, 0.83, 0.15), 0.8)
	# Small crystals at compass points
	for i in 4:
		var ca = i * PI * 0.5
		var cp = Vector2(cg_x + cos(ca) * 12, cg_y + sin(ca) * 8)  # squished circle for perspective
		draw_circle(cp, 2.0, Color(0.54, 0.42, 0.83, 0.2))
	# Center crystal
	draw_circle(Vector2(cg_x, cg_y), 3.0, Color(0.54, 0.42, 0.83, 0.25))

	# ── Wind chimes (hanging from top) ──
	var wc_x = w * 0.55
	var wc_y = h * 0.06
	# Hanger bar
	draw_line(Vector2(wc_x - 12, wc_y), Vector2(wc_x + 12, wc_y), DIM_COLOR, 1.5)
	# String up
	draw_line(Vector2(wc_x, wc_y), Vector2(wc_x, wc_y - 8), FAINT, 0.8)
	# Chime tubes
	for i in 5:
		var cx2 = wc_x - 10 + i * 5
		var chime_len = 14 + i * 3
		var chime_sway = sin(_time * 1.5 + i * 0.9) * 2
		draw_line(Vector2(cx2, wc_y), Vector2(cx2 + chime_sway, wc_y + chime_len), Color(0.65, 0.60, 0.50, 0.3), 1.2)

	# ── Hanging plant (far left, from "ceiling") ──
	var hp_x = w * 0.15
	var hp_y = h * 0.05
	# Rope
	draw_line(Vector2(hp_x, 0), Vector2(hp_x, hp_y + 10), FAINT, 1.0)
	# Pot
	var hp_pts = PackedVector2Array([
		Vector2(hp_x - 8, hp_y + 10),
		Vector2(hp_x - 6, hp_y + 24),
		Vector2(hp_x + 6, hp_y + 24),
		Vector2(hp_x + 8, hp_y + 10),
	])
	draw_colored_polygon(hp_pts, Color(0.55, 0.35, 0.20, 0.3))
	# Trailing vines
	for i in 3:
		var vine_x = hp_x - 6 + i * 6
		var vine_pts = PackedVector2Array()
		for j in 6:
			var vy = hp_y + 24 + j * 8
			var vx = vine_x + sin(j * 1.2 + _time * 0.4 + i) * 5
			vine_pts.append(Vector2(vx, vy))
		draw_polyline(vine_pts, Color(0.35, 0.55, 0.30, 0.3), 1.0)
