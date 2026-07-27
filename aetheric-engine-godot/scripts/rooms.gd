extends RefCounted
class_name Rooms

## Room layout for the Richmond House vertical slice.
## Grok edits this file when adding rooms or moving NPC hotspots.

const ROOMS := {
	"entrance_hall": {
		"title": "Entrance Hall",
		"subtitle": "Arrow keys to walk · E to talk or enter a room",
		"texture": "res://assets/rooms/richmond_entrance_hall.jpg",
		"spawn": [960, 720],
		"walk_bounds": [140, 620, 1640, 920],
		"npcs": [],
		"doors": [
			{"label": "Drawing Room", "target": "drawing_room", "spawn": [200, 700], "rect": [40, 280, 220, 520]},
			{"label": "Gallery", "target": "gallery", "spawn": [960, 700], "rect": [820, 200, 280, 500]},
			{"label": "Kitchen", "target": "kitchen", "spawn": [1200, 700], "rect": [1100, 320, 220, 480]},
			{"label": "Workshop", "target": "workshop", "spawn": [1700, 700], "rect": [1580, 280, 280, 520]},
		],
	},
	"drawing_room": {
		"title": "Drawing Room",
		"subtitle": "Selina's letters, Bell's papers, summer light through tall windows.",
		"texture": "res://assets/rooms/richmond_drawing_room.jpg",
		"spawn": [200, 700],
		"walk_bounds": [120, 620, 1700, 920],
		"npcs": [
			{
				"id": "bell",
				"name": "Ignatius Bell",
				"portrait": "res://assets/portraits/portrait_bell.jpg",
				"intro": "Bell looks up from his papers. The air in the drawing room is still.",
				"rect": [1180, 320, 400, 600],
				"proximity": 140,
			},
			{
				"id": "selina",
				"name": "Selina Deveraux",
				"portrait": "res://assets/portraits/portrait_selina.jpg",
				"intro": "Selina sets down a letter and regards you with composed attention.",
				"rect": [420, 360, 320, 520],
				"proximity": 140,
			},
		],
		"doors": [
			{"label": "Hall", "target": "entrance_hall", "spawn": [960, 700], "rect": [20, 300, 180, 480]},
		],
	},
	"gallery": {
		"title": "The Gallery",
		"subtitle": "High ceilings. Brass and copper. Sound does not rebound too quickly.",
		"texture": "res://assets/rooms/richmond_gallery.jpg",
		"spawn": [960, 700],
		"walk_bounds": [100, 600, 1720, 920],
		"npcs": [
			{
				"id": "amara",
				"name": "Amara Finch",
				"portrait": "res://assets/portraits/portrait_amara.jpg",
				"intro": "Amara stands very still, as though listening to something beneath the floor.",
				"rect": [900, 300, 360, 580],
				"proximity": 140,
			},
		],
		"doors": [
			{"label": "Hall", "target": "entrance_hall", "spawn": [960, 700], "rect": [20, 320, 200, 500]},
			{"label": "Conservatory", "target": "conservatory", "spawn": [1700, 700], "rect": [1680, 280, 200, 500]},
		],
	},
	"conservatory": {
		"title": "Conservatory",
		"subtitle": "Glass roof, potted ferns, Rooke's pacing track worn into the stone.",
		"texture": "res://assets/rooms/richmond_conservatory.jpg",
		"spawn": [200, 700],
		"walk_bounds": [120, 620, 1680, 920],
		"npcs": [
			{
				"id": "rooke",
				"name": "Thomas Rooke",
				"portrait": "res://assets/portraits/portrait_rooke.jpg",
				"intro": "Rooke wipes his hands on a rag and does not quite meet your eye.",
				"rect": [700, 340, 380, 560],
				"proximity": 140,
			},
		],
		"doors": [
			{"label": "Gallery", "target": "gallery", "spawn": [200, 700], "rect": [20, 300, 200, 500]},
		],
	},
	"workshop": {
		"title": "Workshop",
		"subtitle": "Copper fittings, mercury gauges, the honest smell of hot metal.",
		"texture": "res://assets/rooms/richmond_workshop.jpg",
		"spawn": [200, 700],
		"walk_bounds": [100, 600, 1720, 920],
		"npcs": [
			{
				"id": "rooke",
				"name": "Thomas Rooke",
				"portrait": "res://assets/portraits/portrait_rooke.jpg",
				"intro": "Rooke is at the bench. He knows every fault in the machine by touch.",
				"rect": [600, 320, 420, 600],
				"proximity": 140,
			},
		],
		"doors": [
			{"label": "Hall", "target": "entrance_hall", "spawn": [1700, 700], "rect": [20, 300, 200, 500]},
		],
	},
	"kitchen": {
		"title": "Kitchen",
		"subtitle": "Warm tiles, larder alcove, the household's unguarded truth.",
		"texture": "res://assets/rooms/richmond_kitchen.jpg",
		"spawn": [960, 700],
		"walk_bounds": [120, 620, 1680, 920],
		"npcs": [
			{
				"id": "clara",
				"name": "Clara Keene",
				"portrait": "res://assets/portraits/portrait_clara.jpg",
				"intro": "Clara glances toward the corridor before she speaks.",
				"rect": [500, 360, 340, 540],
				"proximity": 140,
			},
		],
		"doors": [
			{"label": "Hall", "target": "entrance_hall", "spawn": [1200, 700], "rect": [20, 300, 200, 500]},
		],
	},
}

static func get_room(id: String) -> Dictionary:
	return ROOMS.get(id, ROOMS["entrance_hall"])

static func rect_center(rect: Array) -> Vector2:
	return Vector2(rect[0] + rect[2] * 0.5, rect[1] + rect[3] * 0.5)

static func point_in_rect(point: Vector2, rect: Array) -> bool:
	return Rect2(rect[0], rect[1], rect[2], rect[3]).has_point(point)

static func distance_to_rect(point: Vector2, rect: Array) -> float:
	var r := Rect2(rect[0], rect[1], rect[2], rect[3])
	var cx := clampf(point.x, r.position.x, r.position.x + r.size.x)
	var cy := clampf(point.y, r.position.y, r.position.y + r.size.y)
	return point.distance_to(Vector2(cx, cy))